# SageMath Check: 選択集合の偶部分グラフ作用と文字和

**対象ラベル**: `claim_selection_even_subgraph_action_character`,
`claim_selection_even_subgraph_action_simply_transitive`,
`claim_selection_sum_character_evaluation`

（あわせて `def_signed_selection_sum`, `claim_selection_sum_signed_count` の被加数・符号指数を使う。）

一辺 $L=2$ の全ファイバー $(D,E)$ について、選択集合が空かを判定する。空でなければ、
任意の選択 $C\in\mathcal C_L(D,E)$ と $\operatorname{Even}_L(H)$ を満たす任意の $H\subseteq E$
について $C\mathbin\triangle H\in\mathcal C_L(D,E)$ であることと、選択符号の指数差が

$$
\vartheta(D,E;C\mathbin\triangle H)-\vartheta(D,E;C)
\equiv \varepsilon_{\mathrm h}(E)\varepsilon_{\mathrm v}(H)
+\varepsilon_{\mathrm v}(E)\varepsilon_{\mathrm h}(H)\pmod 2
$$

に等しいことを全対で検査する（`claim_selection_even_subgraph_action_character` の二つの主張）。
さらに、この対称差作用が選択集合の上で単純推移的であること
（`claim_selection_even_subgraph_action_simply_transitive`）を検査する。
選択集合が空なら選択和は零である。空でない場合、右辺は $H$ の文字なので、非自明なら選択和は対消滅して零、
自明なら全ての選択が同じ符号を持ち、選択和はその符号と選択集合の元数の積になる
（`claim_selection_sum_character_evaluation`）。

- 実行: `sage sagemath/check/selection-sum-affine-character/check.sage`
- 状態: PASS（2026-09-03。一般の辺長の単純推移性と選択和評価を本文へ追加後に再実行）
- 方法: 有限集合、$\mathbb F_2$ の算術、$\mathbb Z$ の有限和だけ。浮動小数点は使わない。
- 結果: 全 $609$ ファイバー×四スピン構造の $2{,}436$ 組を検査した。選択集合が空なのは
  $192$ ファイバー、非空の場合に非自明文字で零になるのは $192$ 組、文字が自明で
  全項が同符号になるのは $1{,}476$ 組だった。
