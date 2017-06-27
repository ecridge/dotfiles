/**
 * See <https://hyper.is#cfg> for all currently supported options.
 */
module.exports = {
  config: {
    fontSize: 14,
    fontFamily: '"Droid Sans Mono Slashed for Powerline", "Droid Sans Mono", Consolas, monospace',
    cursorColor: '#586e75',
    cursorShape: 'BLOCK',
    cursorBlink: false,
    foregroundColor: '#839496',
    backgroundColor: '#002b36',
    borderColor: '#002b36',
    css: '.header_header { background-color: #073642; font-weight: bold }',
    termCSS: '',
    padding: '4px',
    colors: {
      black: '#073642',
      red: '#dc322f',
      green: '#859900',
      yellow: '#b58900',
      blue: '#268bd2',
      magenta: '#d33682',
      cyan: '#2aa198',
      white: '#eee8d5',
      lightBlack: '#002b36',
      lightRed: '#cb4b16',
      lightGreen: '#586e75',
      lightYellow: '#657b83',
      lightBlue: '#839496',
      lightMagenta: '#6c71c4',
      lightCyan: '#93a1a1',
      lightWhite: '#fdf6e3'
    },
    shell: '',
    shellArgs: [
      '--login'
    ],
    windowSize: [825, 620],
    env: { },
    bell: false,
    copyOnSelect: false,
    quickEdit: false
  },
  plugins: [
    'hyper-nobold',
    'hypercwd',
    'hyperlinks',
    'hyperterm-alternatescroll',
    'hyperterm-close-on-left',
    'hyperterm-paste',
    'hyperterm-tabs'
  ],
  localPlugins: []
};
