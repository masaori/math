# 語長 1 の二次式解の正準代表と係数の形

**対象ラベル**: `claim_kac_ward_determinant_fiber_stratified_phase_sum`

`parity-identity-simple-cycle-arc-orientation-length-one-existence` で、語長 $1$ の
制限が特徴ビットの二次式になる解が orient_d 合同系の解空間に存在すると確定した。
ここでは解の取り方に依存しない形でその二次式を一つ構成する。係数座標
（定数項 $1$・一次 $44$・相異なる二成分の積 $946$ の計 $991$）へ射影した核の
既約階段基底で特殊解の係数部分を消去した正準代表（剰余類の正準形。解空間だけで
決まる）を取り、核のどのベクトルも動かさない「強制された係数」を数え、
正準代表の二次式が定める語長 $1$ の値を合同系へ代入して残りが可解であることを
直接検証する。

- 実行: `sage sagemath/check/parity-identity-simple-cycle-arc-orientation-length-one-quadratic-solution/check.sage`
- 状態: **PASS**（2026-09-05）。

  | 観測 | 値 |
  | --- | --- |
  | 連立系の核の次元 | $3{,}069$ |
  | 係数座標へ射影した核の次元 | $946$（自由度は係数側にほぼ全部残る） |
  | 強制された係数（全解で共通の係数） | $0$ 個 |
  | 正準代表 | 定数項 $0$・一次項 $0$ 個・**二次項 $16$ 個** |
  | 二次項の内訳 | 全 $16$ 項が切断旗を含む積。端点第二成分の切断旗を含む積が $16$ 項中 $16$ 項（うち端点同士 $10$・ステップ×端点 $6$） |
  | 代入の可解性 | 正準代表の二次式で語長 $1$ の値を固定しても合同系の残りは可解 |

  正準代表の二次項（$\mathbb F_2$ 上の和）:
  `step_wrap_rowlast*end1_wrap_col0`, `step_wrap_rowlast*end1_wrap_collast`,
  `step_wrap_collast*end1_wrap_collast`, `step_d_down*end1_wrap_collast`,
  `step_d_right*end1_wrap_col0`, `step_d_right*end1_wrap_collast`,
  `end1_e_left*end1_wrap_collast`, `end1_c_left*end1_wrap_col0`,
  `end1_d_right*end1_wrap_rowlast`, `end1_d_right*end1_wrap_col0`,
  `end1_e_right*end1_wrap_rowlast`, `end1_e_right*end1_wrap_col0`,
  `end1_c_right*end1_wrap_rowlast`, `end1_wrap_row0*end1_wrap_collast`,
  `end1_wrap_rowlast*end1_wrap_col0`, `end1_wrap_rowlast*end1_wrap_collast`
  （`step_*` は単一ステップ＝内部頂点の E 所属/切断旗/D 所属、`end1_*` は
  正準順で後の端点＝切断頂点の完全署名。スロット順は up, down, left, right、
  切断旗は row0, rowlast, col0, collast）。

  読み方: 語長 $1$ の弧型の値は、定数項も一次項も無しに、切断旗が絡む
  二次単項式 $16$ 個の和で書ける解が存在する。強制された係数が $0$ 個
  なので式の個々の係数はどれも解空間の不変量ではないが、正準代表は
  剰余類だけで決まる決定的な構成であり、切断旗（特に端点第二成分）に
  局在した形になった。観測は assert へ固定し、固定後の再実行でも一致
  （PASS）を確認した。
- 実測時間: 約 $4$ 分（2026-09-05）。
- 方法: 有限集合、$\mathbb F_2$、整数、$\mathbb Q(\zeta_8)$ の厳密演算のみ。
  浮動小数点は使わない。
