# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#admin_user = User.create( uid: "admin", realname: "관리자", email: 'admin@email.com', password: '12341234', confirmed_at: Time.now )
admin_user = User.create( uid: "admin", realname: "관리자", email: 'admin@email.com', password: '12341234' )
admin_user.add_role :admin

BoardType.create(
	name: "notices",
	realname: "공지사항")