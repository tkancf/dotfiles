import {
  map,
  rule,
  writeToProfile,
} from 'karabiner.ts'

// karabiner-elementsの設定をkarabiner.tsで作成
writeToProfile('karabiner-ts', [
  // バッククオートとチルダを割り当てる
  rule('バッククオートとチルダを割り当てる。').manipulators([
    map('international3', 'optionalAny').to('grave_accent_and_tilde'),
  ]),

  // Shiftキーをオプションキーに置き換える
  rule('Shiftキーをオプションキーに置き換える').manipulators([
    map('left_shift').to('left_option'),
    map('right_shift').to('right_option'),
  ]),

  // スペースキーを単体で押したときはスペース、他のキーと組み合わせたときは左コントロール
  rule('スペースキーを単体で押したときはスペース、他のキーと組み合わせたときは左コントロール').manipulators([
    map('spacebar').to('left_control').toIfAlone('spacebar'),
  ]),

  // 英数・かなキーを他のキーと組み合わせて押したときに、Shiftキーを送信する
  rule('英数・かなキーを他のキーと組み合わせて押したときに、Shiftキーを送信する。').manipulators([
    map('japanese_eisuu').to('left_shift').toIfAlone('japanese_eisuu'),
    map('japanese_kana').to('right_shift').toIfAlone('japanese_kana'),
  ]),

  // caps lockをhyper keyに割り当てる
  rule('Caps Lock → Hyper').manipulators([
    map('caps_lock').toHyper(),
  ]),

])
