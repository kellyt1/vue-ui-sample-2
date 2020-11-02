module.exports = {
  root: true,
  env: {
    node: true
  },
  'extends': [
    'plugin:vue/essential',
    'eslint:recommended'
  ],
  rules: {
    'no-console': process.env.NODE_ENV === 'production' ? 'off' : 'off',
    'no-debugger': process.env.NODE_ENV === 'production' ? 'off' : 'off',
    'no-unused-vars' : 'off',
    'vue/no-unused-vars' : 'off',
    'vue/no-side-effects-in-computed-properties' : 'warning'
  },
  parserOptions: {
    parser: 'babel-eslint'
  }
}
