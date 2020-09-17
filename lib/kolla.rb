require 'paint'
require 'progressbar'

require 'kolla/version'
require 'kolla/animation'
require 'kolla/spinner'
require 'kolla/progress'
require 'kolla/display'

module Kolla
  class Error < StandardError; end
  # Your code goes here...
  extend self

  def spinner
    { class: Kolla::Spinner, animation: :arrow3 }
  end

  def animations=(value)
    @animations = value
  end

  def animations
    @animations ||=
      {
        dots: { interval: 80, frames: %w[⠋ ⠙ ⠹ ⠸ ⠼ ⠴ ⠦ ⠧ ⠇ ⠏] },
        dots2: { interval: 80, frames: %w[⣾ ⣽ ⣻ ⢿ ⡿ ⣟ ⣯ ⣷] },
        dots3: { interval: 80, frames: %w[⠋ ⠙ ⠚ ⠞ ⠖ ⠦ ⠴ ⠲ ⠳ ⠓] },
        dots4: { interval: 80, frames: %w[⠄ ⠆ ⠇ ⠋ ⠙ ⠸ ⠰ ⠠ ⠰ ⠸ ⠙ ⠋ ⠇ ⠆] },
        dots5: { interval: 80, frames: %w[⠋ ⠙ ⠚ ⠒ ⠂ ⠂ ⠒ ⠲ ⠴ ⠦ ⠖ ⠒ ⠐ ⠐ ⠒ ⠓ ⠋] },
        dots6: {
          interval: 80,
          frames: %w[⠁ ⠉ ⠙ ⠚ ⠒ ⠂ ⠂ ⠒ ⠲ ⠴ ⠤ ⠄ ⠄ ⠤ ⠴ ⠲ ⠒ ⠂ ⠂ ⠒ ⠚ ⠙ ⠉ ⠁]
        },
        dots7: {
          interval: 80,
          frames: %w[⠈ ⠉ ⠋ ⠓ ⠒ ⠐ ⠐ ⠒ ⠖ ⠦ ⠤ ⠠ ⠠ ⠤ ⠦ ⠖ ⠒ ⠐ ⠐ ⠒ ⠓ ⠋ ⠉ ⠈]
        },
        dots8: {
          interval: 80,
          frames: %w[⠁ ⠁ ⠉ ⠙ ⠚ ⠒ ⠂ ⠂ ⠒ ⠲ ⠴ ⠤ ⠄ ⠄ ⠤ ⠠ ⠠ ⠤ ⠦ ⠖ ⠒ ⠐ ⠐ ⠒ ⠓ ⠋ ⠉ ⠈ ⠈]
        },
        dots9: { interval: 80, frames: %w[⢹ ⢺ ⢼ ⣸ ⣇ ⡧ ⡗ ⡏] },
        dots10: { interval: 80, frames: %w[⢄ ⢂ ⢁ ⡁ ⡈ ⡐ ⡠] },
        dots11: { interval: 100, frames: %w[⠁ ⠂ ⠄ ⡀ ⢀ ⠠ ⠐ ⠈] },
        dots12: {
          interval: 80,
          frames: %w[
            ⢀⠀
            ⡀⠀
            ⠄⠀
            ⢂⠀
            ⡂⠀
            ⠅⠀
            ⢃⠀
            ⡃⠀
            ⠍⠀
            ⢋⠀
            ⡋⠀
            ⠍⠁
            ⢋⠁
            ⡋⠁
            ⠍⠉
            ⠋⠉
            ⠋⠉
            ⠉⠙
            ⠉⠙
            ⠉⠩
            ⠈⢙
            ⠈⡙
            ⢈⠩
            ⡀⢙
            ⠄⡙
            ⢂⠩
            ⡂⢘
            ⠅⡘
            ⢃⠨
            ⡃⢐
            ⠍⡐
            ⢋⠠
            ⡋⢀
            ⠍⡁
            ⢋⠁
            ⡋⠁
            ⠍⠉
            ⠋⠉
            ⠋⠉
            ⠉⠙
            ⠉⠙
            ⠉⠩
            ⠈⢙
            ⠈⡙
            ⠈⠩
            ⠀⢙
            ⠀⡙
            ⠀⠩
            ⠀⢘
            ⠀⡘
            ⠀⠨
            ⠀⢐
            ⠀⡐
            ⠀⠠
            ⠀⢀
            ⠀⡀
          ]
        },
        line: { interval: 130, frames: ['-', "\\", '|', '/'] },
        line2: { interval: 100, frames: %w[⠂ - – — – -] },
        pipe: { interval: 100, frames: %w[┤ ┘ ┴ └ ├ ┌ ┬ ┐] },
        simpleDots: { interval: 400, frames: ['.  ', '.. ', '...', '   '] },
        simpleDotsScrolling: {
          interval: 200, frames: ['.  ', '.. ', '...', ' ..', '  .', '   ']
        },
        star: { interval: 70, frames: %w[✶ ✸ ✹ ✺ ✹ ✷] },
        star2: { interval: 80, frames: %w[+ x *] },
        flip: { interval: 70, frames: %w[_ _ _ - ` ` ' ´ - _ _ _] },
        hamburger: { interval: 100, frames: %w[☱ ☲ ☴] },
        growVertical: { interval: 120, frames: %w[▁ ▃ ▄ ▅ ▆ ▇ ▆ ▅ ▄ ▃] },
        growHorizontal: { interval: 120, frames: %w[▏ ▎ ▍ ▌ ▋ ▊ ▉ ▊ ▋ ▌ ▍ ▎] },
        balloon: { interval: 140, frames: [' ', '.', 'o', 'O', '@', '*', ' '] },
        balloon2: { interval: 120, frames: %w[. o O ° O o .] },
        noise: { interval: 100, frames: %w[▓ ▒ ░] },
        bounce: { interval: 120, frames: %w[⠁ ⠂ ⠄ ⠂] },
        boxBounce: { interval: 120, frames: %w[▖ ▘ ▝ ▗] },
        boxBounce2: { interval: 100, frames: %w[▌ ▀ ▐ ▄] },
        triangle: { interval: 50, frames: %w[◢ ◣ ◤ ◥] },
        arc: { interval: 100, frames: %w[◜ ◠ ◝ ◞ ◡ ◟] },
        circle: { interval: 120, frames: %w[◡ ⊙ ◠] },
        squareCorners: { interval: 180, frames: %w[◰ ◳ ◲ ◱] },
        circleQuarters: { interval: 120, frames: %w[◴ ◷ ◶ ◵] },
        circleHalves: { interval: 50, frames: %w[◐ ◓ ◑ ◒] },
        squish: { interval: 100, frames: %w[╫ ╪] },
        toggle: { interval: 250, frames: %w[⊶ ⊷] },
        toggle2: { interval: 80, frames: %w[▫ ▪] },
        toggle3: { interval: 120, frames: %w[□ ■] },
        toggle4: { interval: 100, frames: %w[■ □ ▪ ▫] },
        toggle5: { interval: 100, frames: %w[▮ ▯] },
        toggle6: { interval: 300, frames: %w[ဝ ၀] },
        toggle7: { interval: 80, frames: %w[⦾ ⦿] },
        toggle8: { interval: 100, frames: %w[◍ ◌] },
        toggle9: { interval: 100, frames: %w[◉ ◎] },
        toggle10: { interval: 100, frames: %w[㊂ ㊀ ㊁] },
        toggle11: { interval: 50, frames: %w[⧇ ⧆] },
        toggle12: { interval: 120, frames: %w[☗ ☖] },
        toggle13: { interval: 80, frames: %w[= * -] },
        arrow: { interval: 100, frames: %w[← ↖ ↑ ↗ → ↘ ↓ ↙] },
        arrow2: {
          interval: 80,
          frames: ['⬆️ ', '↗️ ', '➡️ ', '↘️ ', '⬇️ ', '↙️ ', '⬅️ ', '↖️ ']
        },
        arrow3: {
          interval: 120, frames: %w[▹▹▹▹▹ ▸▹▹▹▹ ▹▸▹▹▹ ▹▹▸▹▹ ▹▹▹▸▹ ▹▹▹▹▸]
        },
        bouncingBar: {
          interval: 80,
          frames: [
            '[    ]',
            '[=   ]',
            '[==  ]',
            '[=== ]',
            '[ ===]',
            '[  ==]',
            '[   =]',
            '[    ]',
            '[   =]',
            '[  ==]',
            '[ ===]',
            '[====]',
            '[=== ]',
            '[==  ]',
            '[=   ]'
          ]
        },
        bouncingBall: {
          interval: 80,
          frames: [
            '( ●    )',
            '(  ●   )',
            '(   ●  )',
            '(    ● )',
            '(     ●)',
            '(    ● )',
            '(   ●  )',
            '(  ●   )',
            '( ●    )',
            '(●     )'
          ]
        },
        smiley: { interval: 200, frames: ['😄 ', '😝 '] },
        monkey: { interval: 300, frames: ['🙈 ', '🙈 ', '🙉 ', '🙊 '] },
        hearts: { interval: 100, frames: ['💛 ', '💙 ', '💜 ', '💚 ', '❤️ '] },
        clock: {
          interval: 100,
          frames: [
            '🕐 ',
            '🕑 ',
            '🕒 ',
            '🕓 ',
            '🕔 ',
            '🕕 ',
            '🕖 ',
            '🕗 ',
            '🕘 ',
            '🕙 ',
            '🕚 '
          ]
        },
        earth: { interval: 180, frames: ['🌍 ', '🌎 ', '🌏 '] },
        moon: {
          interval: 80,
          frames: ['🌑 ', '🌒 ', '🌓 ', '🌔 ', '🌕 ', '🌖 ', '🌗 ', '🌘 ']
        },
        runner: { interval: 140, frames: ['🚶 ', '🏃 '] },
        pong: {
          interval: 80,
          frames: [
            '▐⠂       ▌',
            '▐⠈       ▌',
            '▐ ⠂      ▌',
            '▐ ⠠      ▌',
            '▐  ⡀     ▌',
            '▐  ⠠     ▌',
            '▐   ⠂    ▌',
            '▐   ⠈    ▌',
            '▐    ⠂   ▌',
            '▐    ⠠   ▌',
            '▐     ⡀  ▌',
            '▐     ⠠  ▌',
            '▐      ⠂ ▌',
            '▐      ⠈ ▌',
            '▐       ⠂▌',
            '▐       ⠠▌',
            '▐       ⡀▌',
            '▐      ⠠ ▌',
            '▐      ⠂ ▌',
            '▐     ⠈  ▌',
            '▐     ⠂  ▌',
            '▐    ⠠   ▌',
            '▐    ⡀   ▌',
            '▐   ⠠    ▌',
            '▐   ⠂    ▌',
            '▐  ⠈     ▌',
            '▐  ⠂     ▌',
            '▐ ⠠      ▌',
            '▐ ⡀      ▌',
            '▐⠠       ▌'
          ]
        },
        shark: {
          interval: 120,
          frames: [
            "▐|\\____________▌",
            "▐_|\\___________▌",
            "▐__|\\__________▌",
            "▐___|\\_________▌",
            "▐____|\\________▌",
            "▐_____|\\_______▌",
            "▐______|\\______▌",
            "▐_______|\\_____▌",
            "▐________|\\____▌",
            "▐_________|\\___▌",
            "▐__________|\\__▌",
            "▐___________|\\_▌",
            "▐____________|\\▌",
            '▐____________/|▌',
            '▐___________/|_▌',
            '▐__________/|__▌',
            '▐_________/|___▌',
            '▐________/|____▌',
            '▐_______/|_____▌',
            '▐______/|______▌',
            '▐_____/|_______▌',
            '▐____/|________▌',
            '▐___/|_________▌',
            '▐__/|__________▌',
            '▐_/|___________▌',
            '▐/|____________▌'
          ]
        },
        dqpb: { interval: 100, frames: %w[d q p b] },
        weather: {
          interval: 100,
          frames: [
            '☀️ ',
            '☀️ ',
            '☀️ ',
            '🌤 ',
            '⛅️ ',
            '🌥 ',
            '☁️ ',
            '🌧 ',
            '🌨 ',
            '🌧 ',
            '🌨 ',
            '🌧 ',
            '🌨 ',
            '⛈ ',
            '🌨 ',
            '🌧 ',
            '🌨 ',
            '☁️ ',
            '🌥 ',
            '⛅️ ',
            '🌤 ',
            '☀️ ',
            '☀️ '
          ]
        },
        christmas: { interval: 400, frames: %w[🌲 🎄] }
      }
  end
end

Kolla::Display.start do |d|
  d.puts('Calculating how big of a virgin you are...')
  d.indent do
    d.spinner(status: 'Calculating age', complete: 'Done!') { sleep 2 }
    d.spinner(status: 'Calculating sex', complete: 'Done!') { sleep 3 }
    d.spinner(status: 'Calculating height', complete: 'Done!') { sleep 1 }

    d.empty_line

    d.indent do
      d.puts('Whatever my dudes...')
      d.spinner(status: 'Calculating height', complete: 'Done!') do |s|
        sleep 2
        s.animation.interval = 200
        sleep 3
      end
      d.progress do |p|
        50.times do
          p.increment
          sleep 0.25
        end
      end
    end

    d.puts('sup')
  end
end
