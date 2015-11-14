class Attachment < ActiveRecord::Base
	belongs_to :attachable, polymorphic: true
	has_attached_file :contents,
		:path => ":rails_root/public/attaches/:id/:filename",
		:url  => "/attaches/:id/:filename"

	do_not_validate_attachment_file_type :contents
end
