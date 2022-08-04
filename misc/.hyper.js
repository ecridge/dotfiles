/*
 * Custom window CSS.
 */

const css = `
  .hyper_main {
    border-color: #282828 !important;
  }

  .tabs_title {
    color: #ebdbb2;
  }
`

/*
 * Font stacks.
 */

const fontFamily = [
  'Meslo LG S for Powerline',
  'Source Code Pro for Powerline',
  'DejaVu Sans Mono for Powerline',
  'Droid Sans Mono Slashed for Powerline',
  'Source Code Pro',
  'Droid Sans Mono',
  'Consolas',
  'monospace'
].map(font => `'${font}'`).join(', ')

/*
 * Hyper configuration object.
 */

module.exports = {
  config: {
    css,
    bell: false,
    fontFamily,
    fontSize: 14,
    padding: '4px',
    uiFontFamily: fontFamily
  },
  plugins: [
    'hypercwd',
    'hyperlinks',
    'hyperterm-alternatescroll',
    'hyperterm-close-on-left',
    'hyperterm-gruvbox-dark'
  ]
}
