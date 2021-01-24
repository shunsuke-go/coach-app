User.create(
  name: '管理ユーザー',
  email: 'admin@admin.com',
  password: 'admin001',
  password_confirmation: 'admin001',
  admin: true
)

User.create(
  name: 'テストユーザー',
  email: 'guest@guest.com',
  password: 'guest001',
  password_confirmation: 'guest001'
)