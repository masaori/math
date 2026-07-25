#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules
#claim("")[ 
  (0313メモ) 一旦以下は受け入れる(リー環/リー群掘らないと行けなさそうで面倒)

  (1011メモ) と思ったけど、行列の級数の計算をきっちりやればリー環/リー群まで行かなくてもできそう
  $
  exp(X) Y exp(-X)
    &= op("Ad")_(exp(X))(Y) \
    &= exp(op("ad")_X)(Y) \
    &= e^(op("ad")_X)(Y) \
    &= Y + [X, Y] + 1/2 [X, [X, Y]] + dots \
    &= sum_(
      n >= 0
    )^infinity
      (1/n!)
      overbrace(
      [
        X,
        dots,
        [
          X,
          Y
        ]
        dots
      ]
      ,
      n "times")
    \
    &("ただし"n=0"のとき"、
    overbrace(
      [
        X,
        dots,
        [
          X,
          Y
        ]
        dots
      ]
      ,
      n "times")"は、"X"と定める")
  $
]<exp_X_Y_exp_-X>
