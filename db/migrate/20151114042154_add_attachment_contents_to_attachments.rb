class AddAttachmentContentsToAttachments < ActiveRecord::Migration
  def self.up
    change_table :attachments do |t|
      t.attachment :contents
    end
  end

  def self.down
    remove_attachment :attachments, :contents
  end
end
