import {
  map,
  rule,
  writeToProfile,
} from 'karabiner.ts'

// karabiner-elementsの設定をkarabiner.tsで作成
writeToProfile('karabiner-ts', [
  rule('バッククオートとチルダを割り当てる。').manipulators([
    map('international3', 'optionalAny').to('grave_accent_and_tilde'),
  ]),

  rule('Shiftキーをオプションキーに置き換える').manipulators([
    map('left_shift', 'optionalAny').to('left_option'),
    map('right_shift', 'optionalAny').to('right_option'),
  ]),

  rule('CommandキーをShiftに置き換える').manipulators([
    map('left_command', 'optionalAny').to('left_shift'),
    map('right_command', 'optionalAny').to('right_shift'),
  ]),

  rule('英数・かなキーを他のキーと組み合わせて押したときに、Commandキーを送信する。').manipulators([
    map('japanese_eisuu').to('left_command').toIfAlone('japanese_eisuu'),
    map('japanese_kana').to('right_command').toIfAlone('japanese_kana'),
  ]),

  rule('スペースキーを単体で押したときはスペース、他のキーと組み合わせたときは左コントロール').manipulators([
    map('spacebar').to('left_control').toIfAlone('spacebar'),
  ]),

  rule('Caps Lock → Hyper').manipulators([
    map('caps_lock').toHyper(),
  ]),

])
