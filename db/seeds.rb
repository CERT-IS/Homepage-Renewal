# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#admin_user = User.create( uid: "admin", realname: "관리자", email: 'admin@email.com', password: '12341234', confirmed_at: Time.now )
admin_user = User.create( uid: "admin", realname: "관리자", email: 'admin@email.com', password: '12341234', phone: "01012341234" )
admin_user.add_role :admin

BoardType.create(
	name: "notices",
	realname: "공지사항")

BoardType.create(
	name: "frees",
	realname: "자유게시판")

BoardType.create(
	name: "genealogies",
	realname: "족보게시판")

BoardType.create(
	name: "reviews",
	realname: "후기게시판")

BoardType.create(
	name: "galleries",
	realname: "사진첩")

BoardType.create(
	name: "lines",
	realname: "한줄게시판")

BoardType.create(
	name: "grades",
	realname: "등업게시판")

BoardType.create(
	name: "presentations",
	realname: "정기 발표자료")

BoardType.create(
	name: "blogs",
	realname: "기술블로그")

BoardType.create(
	name: "documents",
	realname: "공문자료")