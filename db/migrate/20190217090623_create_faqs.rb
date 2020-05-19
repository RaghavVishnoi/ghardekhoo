class CreateFaqs < ActiveRecord::Migration[5.0]
  def change
    create_table :faqs do |t|
    	t.text :question
    	t.text :answer
    	t.boolean :active
        t.timestamps
    end
  end
end
