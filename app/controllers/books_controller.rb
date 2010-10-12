class BooksController < ApplicationController
  include Meteor::Crud::NamedCell

  def meteor_spec(h={})
    case h[:name]
    when 'book'
      Meteor::Widget::NamedCell::Spec.new do |spec|
        spec.klass = Book
        spec.controller_class = self.class
        spec.title = "Book Details"

        spec.rows.push(
          Meteor::Widget::NamedCell::Row.new do |row|
            row.cell_list.push(
              Meteor::Widget::NamedCell::Column.new do |col|
                col.type = :scalar
                col.name = :title
                col.edit = true
                col.title = "Title"
              end
            )
            column = Meteor::Widget::NamedCell::Column.new do |col|
              col.type = :ref
              col.name = :genre
              col.edit = true
              col.title = "Genre"
            end
            def column.options(object=nil)
              [""] + Genre.find(:all,
                :order => :name).collect{ |g| [g.name, g.id] }
            end
            row.cell_list.push(column)
          end
        )
        spec.rows.push(
          Meteor::Widget::NamedCell::Row.new do |row|
            row.cell_list.push(
              Meteor::Widget::NamedCell::Column.new do |col|
                col.type = :scalar
                col.name = :isbn
                col.edit = true
                col.title = "ISBN"
              end
            )
            row.cell_list.push(
              Meteor::Widget::NamedCell::Column.new do |col|
                col.type = :date
                col.name = :publish_date
                col.edit = true
                col.title = "Date of publish"
              end
            )
          end
        )
      end
    end
  end

  # Tweak to allow users to play with the widget without
  # changing our data.
  def named_cell_inplace_edit
    id = params['id']
    cell_name = params['cell_name']
    spec_name = params['spec']

    raise "cannot find meteor spec for #{spec_name}" unless spec = meteor_spec(:name => spec_name)
    raise 'cannot determine object class' unless _klass = params['object_class']
    raise "no such class #{_klass}" unless klass = self.class.const_get(_klass)
    raise "cannot load object of type #{_klass} with id #{id}" unless object = klass.find(id)

    if params['ref']
      _ref_klass = cell_name.capitalize
      raise "no such class #{_ref_klass}" \
        unless ref_klass = self.class.const_get(_ref_klass)
      if params['value'].blank?
        value = nil
      else
        value = ref_klass.find(params['value'])
      end
    else
      value = params['value']
    end
    object.send("#{cell_name}=", value)
    #object.save!
    #object.reload

    new_value = object.send(cell_name.to_sym)
    output = ""
    [:name, :to_label, :to_s].each do |method|
      if new_value.respond_to? method
        output = new_value.send(method)
        break
      end
    end
    if output.blank?
      output = '-'
    end

    render :inline => CGI.escapeHTML(output)
  end
end
