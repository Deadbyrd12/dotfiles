local wk = require('which-key')

wk.setup ({
  icons = {
    separator = '->',
    group = ''
  }
})

wk.register({
  f = { name = 'file' },
  r = { name = 'refactor' },
  u = '[u]ndotree'
}, { prefix = '<leader>'})
