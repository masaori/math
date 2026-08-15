# MEMORY — 2次元 Ising 模型の厳密解（Λ・Fisher 零点の立場）

作業前に [README.md](README.md) と リポジトリ直下の [docs/context/](../docs/context/) を全て読むこと。

## 現在の到達点（2026-08-15 時点）

2026-08-15 の tick 290 は、レビューで前 tick の「開境界密度の下からの評価と下限の存在」の下限の証明の
係数表記を主張の $\iota_{\mathbb{Q}\to\mathbb{R}}(2)$ へ揃え、SageMath 概要の「対象ラベル」が箇条書き形式で
対応検査 `verify-check-linkage.ts` の正規表現（`**対象ラベル**: \`...\`` を行頭に置く一行形式）に合わず
検査が落ちていたのを直して push した（**overview.md の対象ラベルは一行形式で書く**）。そのあと同セクションの
Lean を完成させ、セクションを閉じた。具体版 `ThermodynamicLimit/OpenFreeEnergyDensityLowerBound.lean`
（辺数 `openSquareEdgeCount`、$2t^{E_L}\le Z^{\mathrm{op}}$ と $t^{2L^2}\le2t^{E_L}$、
`openSquareFreeEnergyDensity_lowerBound_of_le_one`）と `OpenFreeEnergyDensityInfimum.lean`
（値集合を符号反転して上限の存在を適用し戻す `openFreeEnergyDensityValueSet_has_infimum_of_le_one`）。
必要十分版 `NecSuf/ThermodynamicLimit/OpenFreeEnergyDensityLowerBound.lean` の
`scaled_map_lowerBound_necSuf`（下界を写像で運ぶ・尺度の合成・係数の相殺のみ）と
`NecSuf/ThermodynamicLimit/OpenFreeEnergyDensityInfimum.lean` の `indexedValueSet_has_infimum_necSuf`
（証人・一様下界・順序を反転する対合・上限の存在のみ。順序の反射律・推移律も不要）。sorry 検査 1049 件。
次の本文は「倍数の辺での下限への任意近接（$0<t\le1$ の場合）」（$1\le t$ の上限版
`claim_open_free_energy_density_supremum_approximation_multiples_one_le` と対称。下限 $v$ と
$\varepsilon$ に対し $v+\varepsilon$ が下界でないことから一辺 $a$ を取り、ブロック敷き詰め評価の対数化の
$\psi^{\mathrm{op}}_{ka}\le\psi^{\mathrm{op}}_a$ と下界性で $v\le\psi^{\mathrm{op}}_{ka}<v+\varepsilon$）。
式変形統一では姉妹側「$\check Z,\check Y$ の $n$ 重交換子」の (h2.y) の第二帰納段階を二行へ開いた
（残りは (h2.z) の二つの帰納段階の同じ箇所）。

2026-08-15 の tick 289 は、レビューで前 tick の「倍数の辺での上限への任意近接（$1\le t$）」の
有限モデル上界判定を、ball 差の下端判定から分配関数の整数冪による厳密比較へ修正し、前進前に
push した。そのあと「開境界密度の下からの評価と下限の存在」を本文と SageMath まで進めた。
$2t^{2L(L-1)}\le Z^{\mathrm{op}}_{L,L}(t)$ と $t^{2L^2}\le2t^{2L(L-1)}$ から
$2\log_{\mathbb R}t\le\psi^{\mathrm{op}}_L(t)$ を得た。下限は値集合を符号反転して上限の存在を適用し、
再び符号を戻して構成した。SageMath は 56 件を検査。**Lean は未着手**なので次 tick は同じ
セクションの具体版・必要十分版・導出版を完成させる。式変形統一では姉妹側 (h2.y) の第一帰納段階の
最後を、スカラー整理と冪の指数法則の二行へ開いた。

2026-08-15 の tick 288 は、レビューで前 tick の「開境界密度の上からの評価と値集合の上限の存在」の
本文・SageMath・Lean が一致することを確認した。ただし前 tick の Lean 定理 5 件が sorry 検査の登録一覧
（`lean/scripts/check-no-sorry.sh` の `targets`）に無かったので登録した（**Lean を書いたら登録一覧へも足す**）。
そのあと「倍数の辺での上限への任意近接」を $1\le t$ の場合に限って四層まで完成させた
（`claim_open_free_energy_density_supremum_approximation_multiples_one_le`）。上限 $u$ と
$\varepsilon>0$ に対し、$u-\varepsilon$ が上界でないことから一辺 $a$ を取り、ブロック敷き詰め評価の
対数化の $\psi^{\mathrm{op}}_a\le\psi^{\mathrm{op}}_{ka}$ と上界性で、すべての $k\ge1$ について
$u-\varepsilon<\psi^{\mathrm{op}}_{ka}(t)\le u$ を得た。SageMath は単調性を有理数の指数側の不等式
$Z_a^{(ka)^2}\le Z_{ka}^{a^2}$ として厳密に 16 件、有限モデルを ball 算術で 14 件検査した。Lean は
`ThermodynamicLimit/OpenFreeEnergyDensitySupremumApproximationMultiples.lean`（具体版）、
`NecSuf/ThermodynamicLimit/OpenFreeEnergyDensitySupremumApproximationMultiples.lean`
（線形順序・上限・倍数写像に沿った単調性だけ）、`...FromNecSuf.lean`（導出）。
**重要な発見（割り直し）**: $0<t\le1$ では開境界密度の上限は極限ではない。一辺 $1$ の開境界正方形は
辺を持たないので $\psi^{\mathrm{op}}_1(t)=\log_{\mathbb R}2$ がすべての $L$ の値の上界であり、
倍数列は $\psi^{\mathrm{op}}_{ka}\le\psi^{\mathrm{op}}_a$ と減少して**下限**へ向かう。
そこで $0<t\le1$ 用に「開境界密度の下からの評価と下限の存在」
（$Z^{\mathrm{op}}_{L,L}(t)\ge2t^{2L(L-1)}$ から $\psi^{\mathrm{op}}_L(t)\ge2\log_{\mathbb R}t$、
完備性で $\inf$）と「倍数の辺での下限への任意近接（$0<t\le1$）」を台帳の先頭へ足した。
「倍数でない辺への拡張」以降は、$1\le t$ は上限、$0<t\le1$ は下限を極限値として閉じる。
式変形統一では姉妹側「$\check Z,\check Y$ の $n$ 重交換子」（`014_even_sector_T_action`）の (h2.y) の基底段階 $F_0$ を、(h2.z) と同じ二段の等号鎖へ開いた（次は同じ証明の帰納段階以降、または次の証明）。
次の本文は「開境界密度の下からの評価と下限の存在」。

2026-08-15 の tick 287 は、レビューで前 tick の「ブロック敷き詰め評価の対数化」の本文・
SageMath・Lean 三本が一致することを確認した（修正無し）。そのあと「開境界密度の上からの評価と
値集合の上限の存在」を四層まで完成させた。開境界の辺数 $2L(L-1)\le2L^2$ と配位数 $2^{L^2}$ から
$Z^{\mathrm{op}}_{L,L}(t)\le2^{L^2}(1+t)^{2L^2}$ を得て、実対数と $1/L^2$ 倍により
$\psi^{\mathrm{op}}_L(t)\le\log_{\mathbb R}2+2\log_{\mathbb R}(1+t)$ とした。値集合は空でなく上に
有界なので実数の完備性から上限を持つ。SageMath は可算側を厳密、実対数を ball 算術で 20 件検査。
Lean は具体版と、既存の上界・上限の必要十分版からの導出を実装した。式変形統一では姉妹側
「$\check Z,\check Y$ の $n$ 重交換子」の (h2.z) の基底段階を二段の等号鎖へ開いた。
次の本文は「倍数の辺での上限への任意近接」。

2026-08-15 の tick 286 は、レビューで前 tick の「ブロック敷き詰め評価の対数化」の証明中、
実対数の乗法加法性・狭義単調性の根拠 4 箇所に `\blkref{remark_real_logarithm}` が無かったので付けて
push した。そのあと同セクションの Lean を完成させ、セクションを閉じた。具体版
`lean/Ising2DLambda/ThermodynamicLimit/OpenSquareBlockTilingLogarithm.lean` は、補正項
`blockTilingCorrection`（$\delta_{a,k}(t)$）と一辺 $ka$ の `squareSide` を置き、下側・上側の対数の
展開補題、係数の約分補題二本（有理数の等式。`field_simp` で閉じる）、二場合の定理
`openSquareFreeEnergyDensity_blockTiling_bounds_of_le_one/of_one_le` を人手証明と同じ順
（ブロック評価→実対数の単調性→積と冪の対数の展開→正の係数の乗法→約分）で辿った。必要十分版
`scaled_map_twoSided_bounds_necSuf` は順序を保つ写像・像の二項分解・尺度作用の分配と係数の相殺
だけを仮定し（$A$ の加法の可換性も $K$ の乗法も不要）、$1\le t$ の場合は順序の向きを反転して
同じ定理から導いた。本文へ `lean` 宣言を付け、SageMath 概要の「Lean 未着手」を実態へ直した。
sorry 検査 1032 件、すべて非依存。式変形統一では姉妹側「$\check Z,\check Y$ の $n$ 重交換子」の
(h1.y) の基底段階 $D_0$ を (h1.z) と同じ二段の等号鎖へ開いた。次の本文は「開境界密度の上からの評価と値集合の上限の存在」
（開境界の値の上界 → $\psi^{\mathrm{op}}_L(t)$ の $L$ に依らない上界 → 完備性で上限。周期境界側の
`FreeEnergyDensityUpperBound.lean`・`FreeEnergyDensitySupremum.lean` と同じ形にできるはず。
開境界の値の上界は `PartitionValueUpperBound` の開境界版が要るか、$Z^{\mathrm{op}}_{L,L}(t)\le
Z_L(t)$ 型の比較で済むかを最初に確かめる）。

2026-08-15 の tick 285 は、レビューで前 tick の「開境界正方形の自由エネルギー密度」の本文・
SageMath・Lean 定義が一致することを確認した（修正無し）。そのあと「ブロック敷き詰め評価の
対数化」`claim_open_square_block_tiling_logarithm` を本文と SageMath まで進めた。
$\delta_{a,k}(t):=\iota(2(k-1)/(ka))\log_{\mathbb{R}}t$ と置き、$0<t\le1$ では
$\delta_{a,k}(t)+\psi^{\mathrm{op}}_a(t)\le\psi^{\mathrm{op}}_{ka}(t)\le
\psi^{\mathrm{op}}_a(t)$、$1\le t$ では逆向きの挟み込みを得た。SageMath は正の有理点
7 点と $(a,k)$ 5 組の上下評価 35 件を ball 算術で、有理係数の約分 10 件を厳密検査した。
**Lean は未着手**なので次 tick は具体版・必要十分版・導出版を完成させる。式変形統一では姉妹側
「$\check Z$ の $n$ 重交換子」の基底段階を一続きの等号と行末根拠へ開いた。

2026-08-15 の tick 284 は、レビューで前 tick の「開境界正方形のブロック敷き詰め評価」の本文・
SageMath・Lean 具体版を突き合わせ、一致を確認した（修正無し）。そのあと「開境界自由エネルギー密度の
極限」を論法ごとに五つ（定義、ブロック敷き詰め評価の対数化、上からの評価と上限の存在、倍数の辺での
上限への任意近接、倍数でない辺への拡張）へ割り直し、先頭の「開境界正方形の自由エネルギー密度」
`def_open_square_free_energy_density` を閉じた。
$\psi^{\mathrm{op}}_L(t):=\iota_{\mathbb{Q}\to\mathbb{R}}(1/L^2)\cdot\log_{\mathbb{R}}(Z^{\mathrm{op}}_{L,L}(t))$
を周期境界の $\psi_L$ と同じ形で定め、開境界の値の正値性で実対数の定義域へ入れた。SageMath
`open-square-free-energy-density` は可算側を厳密、実対数を ball 算術で計 48 件。Lean は
`ThermodynamicLimit/OpenSquareFreeEnergyDensity.lean` に定義 `openSquareFreeEnergyDensity` を置いた
（定義ブロックなので必要十分版・導出版は無い。`lake build`・sorry 検査 1023 件通過）。
次の本文は「ブロック敷き詰め評価の対数化」（一辺 $ka$ の $\psi^{\mathrm{op}}_{ka}(t)$ を、
$\psi^{\mathrm{op}}_a(t)$ と $\log_{\mathbb{R}}t$ の有理数倍で二場合に挟む。必要な道具は実対数の
単調性・積・冪 `claim_real_log_natural_power`。$t$ の冪の指数は合計 $2(k-1)ka$ で、$(ka)^2$ で
割ると $2(k-1)/(ka)$）。式変形統一では姉妹側「偶セクターの転送行列の共役作用」の反復交換子の
証明の準備にあった交換子の双線型性の行内三等号鎖を一行一等号と行末根拠へ開いた。

2026-08-15 の tick 283 は、レビューで前 tick の「開境界長方形を第二座標方向へ反復接合した値の
評価」の本文・SageMath・Lean 三本を突き合わせ、一致を確認した（修正無し）。そのあと
「開境界正方形のブロック敷き詰め評価」を四層まで完成させた。第一座標方向の反復接合で
$a\times a$ ブロック $k$ 個から $ka\times a$ の帯を作り、その上下評価を $k$ 乗して、第二座標方向の
反復接合評価へ代入した。これにより一辺 $ka$ の正方形を $k^2$ ブロックの値で二場合に挟んだ。
SageMath は正の有理点 5 点と $(a,k)$ 5 組の計 25 組を厳密検査した。Lean 具体版
`OpenSquareBlockTiling.lean` は人手証明と同じ二方向の合成を辿り、必要十分版
`two_direction_pow_bounds_necSuf` は二段の因子つき冪評価だけを残し、導出版二本で具体版への
特殊化を示した。式変形統一では姉妹側「偶セクターの転送行列の共役作用」の最初の証明で、
行末根拠を実在ラベル参照へ揃えた。次の本文は「開境界自由エネルギー密度の極限」
（このブロック評価と上限への任意近接を組み合わせる）。

2026-08-15 の tick 282 は、レビューで前 tick の「開境界長方形を第二座標方向へ反復接合した値の評価」の
本文と SageMath（40 組）と第二座標方向の一回の接合不等式の Lean を突き合わせ、一致を確認した
（修正無し）。そのあと同セクションの Lean を完成させ、セクションを閉じた。具体版
`lean/Ising2DLambda/ThermodynamicLimit/OpenRectangleIteratedGluingSecond.lean` は、第一座標方向と
同じ帰納法を接合面の長さ $a$・接ぐ辺を第二座標に入れ替えて人手証明と同じ順で辿った
（$k=1$ の底の等号鎖、$ka=a+(k-1)a$、冪の指数法則、帰納法の仮定と正数の乗法、第二座標の長さ
$kb$ と $b$ への接合不等式、$(k+1)b=kb+b$）。必要十分版は接ぐ向きに依らない
`iterated_glue_pow_bounds_necSuf` をそのまま使い（新しい必要十分版ファイルは作らない）、導出二定理
`OpenRectangleIteratedGluingSecondFromNecSuf.lean` は low/high へ $t^a$ と $1$ を代入して二場合を
復元した。本文の `claim_open_rectangle_iterated_gluing_second` へ `lean` 宣言を付け、SageMath 概要の
「Lean 未着手」を実態へ直した（sorry 検査 1018 件、すべて非依存）。次の本文は
「開境界正方形のブロック敷き詰め評価」（二方向の反復接合を組み合わせ、一辺 $L=ka$ の正方形を
$a\times a$ ブロック $k^2$ 個の値で挟む。第一座標方向の反復で $Z^{op}_{ka,a}$ を $Z^{op}_{a,a}$ の冪で
挟み、続けて第二座標方向の反復で $Z^{op}_{ka,ka}$ を $Z^{op}_{ka,a}$ の冪で挟む順が自然）。
式変形統一では姉妹側「半整数運動量のモード」（`013_even_sector_modes`）の反周期性の証明末尾の
二等号の行を一行一等号と行末根拠へ開いた。

2026-08-15 の tick 281 は、レビューで前 tick の第一座標方向の反復接合評価について、本文・
SageMath・Lean 具体版・必要十分版・導出版が一致することを確認した（修正無し）。そのあと
「開境界長方形を第二座標方向へ反復接合した値の評価」を本文と SageMath まで進めた。
一回の第二座標方向の接合不等式を反復回数 $k$ について帰納的に適用し、接合面 $k-1$ 本が
与える因子 $t^{(k-1)a}$ を含む二場合の上下評価を得た。SageMath は正の有理点 5 点と
長方形・反復回数 8 組の計 40 組を厳密検査した。**Lean は未着手**なので、次 tick は具体版・
必要十分版・導出版を完成させる。式変形統一では姉妹側「半整数運動量の指数和」の二つの等号へ
行末根拠を付けた。

2026-08-15 の tick 280 は、レビューで前 tick の「開境界長方形を第一座標方向へ反復接合した値の評価」の
本文と SageMath（40 組）を突き合わせ、一致を確認した（修正無し）。そのあと同セクションの Lean を
完成させ、セクションを閉じた。具体版
`lean/Ising2DLambda/ThermodynamicLimit/OpenRectangleIteratedGluingFirst.lean` は、反復回数 $k$ の
帰納法を人手証明と同じ順（$k=1$ の底の等号鎖、$kb=b+(k-1)b$、冪の指数法則、帰納法の仮定と
正数の乗法、一辺 $ka$ と $a$ への接合不等式、$(k+1)a=ka+a$）で辿った。必要十分版
`iterated_glue_pow_bounds_necSuf` は格子・配位・実数を外し、一段の上下評価
$\mathrm{low}\cdot(P_k z)\le P_{k+1}\le\mathrm{high}\cdot(P_k z)$ と底 $P_1=z$ から
$\mathrm{low}^{k-1}z^k\le P_k\le\mathrm{high}^{k-1}z^k$ を出す帰納法だけを残した
（**積の可換性は不要と判明**し `Semiring` + `PartialOrder` + `IsOrderedRing` で通る。
一回の接合の必要十分版は `CommSemiring` を要するのと対照的）。導出二定理は low/high へ
$t^b$ と $1$ を代入して二場合を復元した。本文の `claim_open_rectangle_iterated_gluing_first` へ
`lean` 宣言を付けた（sorry 検査 1014 件、すべて非依存）。次の本文は
「開境界長方形を第二座標方向へ反復接合した値の評価」（第一座標方向と同じ帰納法を座標交換で移す。
接合不等式の第二方向 `openPartitionValue_glueSecond_bounds_*` が既にあるので、同じ形の帰納法で
閉じるはず）。式変形統一では姉妹側「なぜ (−) セクターだけを使うか」（`013_even_sector_modes`）の
証明中、根拠なしで終わる四つの鎖の末尾行へ行末根拠を付けた。

2026-08-15 の tick 279 は、レビューで前 tick の「周期境界と開境界の境界評価」の実数評価について、
本文・SageMath・Lean 三本を突き合わせた。数学内容と四層の対応は揃っていたが、SageMath の概要だけが
Lean 未了と記したままだったため、完成済みという実態へ訂正し、前進前に main へ反映した。そのあと
「自由エネルギー密度の極限の存在」を論法ごとに五つへ割り直し、先頭の「開境界長方形を
第一座標方向へ反復接合した値の評価」を本文と SageMath まで進めた。一回の接合不等式を反復回数
$k$ について帰納的に適用し、接合面 $k-1$ 本が与える因子を含む二場合の上下評価を得た。
SageMath は正の有理点 5 点と長方形・反復回数 8 組の計 40 組を厳密検査した。Lean は未着手なので、
次 tick は具体版・必要十分版・導出版を完成させる。式変形統一では姉妹側
「$e^{\mathrm{ad}_X}(Y)$ の級数展開」の反復交換子の等式へ、再帰的定義という行末根拠を付けた。

2026-08-15 の tick 278 は、レビューで前 tick の辺の直和分解・境界破れ本数の上界・
破れボンド数の分解が本文と一致していることを確認し（修正無し）、そのあと
「周期境界と開境界の境界評価」の実数評価の上下評価の Lean を完成させ、セクションを閉じた。
具体版 `lean/Ising2DLambda/ThermodynamicLimit/PeriodicOpenComparisonInequality.lean` は、
全単射 $r_L$ に沿う和の並べ替え・破れボンド数の分解・冪の指数法則による書き換え
`partitionValue_eq_open_double_product` と、$0<t\le1$／$1\le t$ の二場合の上下評価
`partitionValue_periodicOpen_bounds_of_le_one/of_one_le` を人手証明と同じ順で辿った
（冪の順序は接合不等式と同じ帰納法の補題を使い、mathlib の既製単調性へ委ねない）。
必要十分版 `sum_pow_reindex_bounds_necSuf` は格子・配位・実数を外し、添字の全単射・
指数の二項分解・境界因子の項ごとの評価・可換半環の順序
（`CommSemiring` + `PartialOrder` + `IsOrderedRing`）だけを残した（接合不等式の
必要十分版と違い、添字の対の構造は不要と判明）。導出二定理で具体版が特殊化として
得られることを示し、本文の `claim_periodic_open_boundary_comparison` へ `lean` 宣言を
付けた（sorry 検査 1009 件、すべて非依存）。これで「周期境界と開境界の境界評価」の
四層が揃った。式変形統一では姉妹側「行列版 $e^{X}Ye^{-X}=e^{\mathrm{ad}_X}(Y)$」の
証明中、冪のノルム評価の帰納法の底 $l=1$ の行内三等号鎖 $\|X^{1}\|=\|X\|=a=a^{1}$ を
一行一等号と行末根拠へ開いた。次の本文は「自由エネルギー密度の極限の存在」
（接合不等式と境界評価から導く。列 $\psi_L(t)$ は単調とは限らないので、
劣加法性・上限への任意近接・境界評価の組み合わせで閉じる道具立てを検討する）。

2026-08-15 の tick 277 は、前 tick の頂点対応・配位の全単射を本文の
$v_L$・$r_L$ と突き合わせ、往復の向きと定義域・値域が一致していることを確認した
（修正無し）。そのあと「周期境界と開境界の境界評価」の「破れボンド数の分解」の
Lean 具体版を完成させた。`PeriodicOpenComparison.lean` で周期辺の前半・後半を
横向き・縦向きの行列座標へ開き、各向きの最後の列・行を境界横断辺、それ以外を
開境界辺とする全単射 `periodicOpenEdgeEquiv` を構成した。辺の三部分で破れる条件を
端点写像と配位の読み替えに沿って一つずつ照合し、境界破れ本数の上界
`periodicBoundaryBrokenCount_le` と分解 `brokenBondCount_openConfigToPeriodic` を得た。
**claim 本体の Lean は未了**なので本文の `lean` 宣言はまだ付けない。次 tick は
「実数評価の上下評価」の Lean 具体版・必要十分版・導出を進める。式変形統一では
姉妹側「$\mathrm{ad}_X$ と $\mathrm{Ad}_g$ の定義」に埋め込まれていた逆行列の一意性の
五等号の圧縮鎖を、一行一等号と行末根拠へ開いた。

2026-08-15 の tick 276 は、レビューで前 tick の「周期境界と開境界の境界評価」の証明に残っていた
無名の同一視（配位の全単射に名前を付けず、周期境界と開境界の配位を同じ文字 $\sigma$ で使い回す
書き方）を、頂点対応 $v_L(i,j)=(s(i),s(j))$ とその逆写像、配位の全単射
$r_L(\tau)=\tau\circ v_L$ の定義へ書き直し、分解を $b(r_L(\tau))=b^{\mathrm{op}}_{L,L}(\tau)+s^{\mathrm{bd}}_L(\tau)$、
和の書き換えを「全単射 $r_L$ に沿う和の並べ替え」の行として明示して、前進前に main へ反映した
（コミット `cf66b444`）。そのあと同セクションの Lean を論法ごとに「配位の全単射」
「破れボンド数の分解」「実数評価の上下評価」の三つへ割り直し、先頭の「配位の全単射」の具体版
`lean/Ising2DLambda/ThermodynamicLimit/PeriodicOpenComparison.lean` を完成させた。頂点対応
`periodicVertexToOpen`（代表を取る写像は `ZMod.val`、自然な射影は `Nat.cast`）と逆写像、
往復の等式二本、配位の読み替え `openConfigToPeriodic`（$r_L$）と逆写像、往復の等式二本、
全単射 `periodicOpenVertexEquiv`・`periodicOpenConfigEquiv` を人手証明と 1 対 1 に写し、
sorry 検査へ登録した（1000 件、すべて非依存）。**claim 本体の Lean は未了**なので本文の
`lean` 宣言はまだ付けない。次 tick は「破れボンド数の分解」の Lean（周期境界の辺集合と
開境界の辺＋境界横断辺 $2L$ 本の直和との全単射、$b(r_L(\tau))$ の分解）を進める。
式変形統一では姉妹側「Frobenius 内積の性質」の場合 1 の $u=0_{\mathbb{C}}$ と Step 6 の
$u+\overline{u}$ に残っていた行内の等号鎖を、一行一等号と行末根拠へ開いた。

2026-08-15 の tick 275 は、レビューで前 tick の接合不等式の数学内容と四層の対応を確認し、
SageMath 概要に残っていた「Lean は次 tick」という古い記述だけを、具体版・必要十分版・導出版が
完成済みという実態へ訂正して前進前に main へ反映した。そのあと「周期境界と開境界の境界評価」を
本文と SageMath まで進めた。周期境界と開境界正方形の配位の全単射、周期境界にだけある各向き
$L$ 本ずつの境界横断辺、その破れ本数 $0\le s_L^{\mathrm{bd}}\le2L$、破れボンド数の分解
$b=b^{\mathrm{op}}+s_L^{\mathrm{bd}}$ を置き、自然数冪の順序と有限和から $Z_L(t)$ と
$Z^{\mathrm{op}}_{L,L}(t)$ を $t^{2L}$ 倍までで挟んだ。SageMath は $L\in\{1,2,3\}$ と正の
有理点 5 点の 15 組を厳密検査した。**Lean は未着手**で、次 tick は具体版・必要十分版・導出版を
実装する。式変形統一では姉妹側「Frobenius 内積の性質」の Cauchy--Schwarz から三角不等式を
導く計算に残っていた複数関係の鎖を、一行一関係と行末根拠へ開いた。

2026-08-15 の tick 274 は、レビューで前 tick の接合面分解の Lean（辺の三分割の全単射・接合面の
破れ辺数と上界・三項分解・座標交換）が本文と一致していることを確認し（修正無し）、そのあと
「開境界長方形の接合不等式」の実数評価の上下評価の Lean を完成させ、セクションを閉じた。具体版
`lean/Ising2DLambda/ThermodynamicLimit/OpenRectangleGluingInequality.lean` は、値
`openPartitionValue`（多項式への代入）と正値性、一以下の底の自然数冪の順序二補題（指数についての
帰納法。mathlib の既製単調性へ委ねない）、全単射と三項分解による二重和への書き換え
（`openPartitionValue_glueFirst_eq/glueSecond_eq`）、積の二重和への展開、項ごとの評価の有限和を
人手証明と同じ順で辿り、第一・第二の座標方向 × `0<t≤1`／`1≤t` の四定理を得た。必要十分版
`sum_pow_glue_bounds_necSuf` は格子・配位・実数を外し、対との全単射・指数の三項分解・
接合面因子の項ごとの評価・可換半環の順序（`CommSemiring` + `PartialOrder` + `IsOrderedRing`）
だけを残した（全順序・減法は不要と判明）。導出四定理で具体版が特殊化として得られることを示し、
本文の二ブロックへ `lean` 宣言を付けた（sorry 検査 994 件、すべて非依存）。式変形統一では
姉妹側「Frobenius 内積の性質」の Cauchy–Schwarz の証明中、$t$ の代入計算の三鎖を一行一等号と
行末根拠へ開いた。次の本文は「周期境界と開境界の境界評価」（境界を横切る辺は $2L$ 本）。

2026-08-15 の tick 273 は、レビューで前 tick の接合写像の Lean 具体版を本文と突き合わせ、
第一・第二座標方向の制限・接合、六つの戻りの等式、二つの全単射、入口 import、sorry 検査の登録が
揃っていることを確認した（修正無し）。そのあと「接合不等式・破れボンド数の接合面分解」の Lean
具体版を完成させた。第一座標方向では接合後の辺集合と「左側・右側・接合面」の直和との全単射
`openEdgeJoinEquivFirst` を構成し、接合面の破れ辺数 `openSeamBrokenCountFirst` が $b$ 以下で
あることと、三項分解 `openBrokenBondCount_glueFirst` を示した。第二座標方向は配位・辺の座標交換
`openConfigTranspose`・`openEdgeTranspose` で第一方向へ帰着し、接合面の破れ辺数が $a$ 以下で
あることと `openBrokenBondCount_glueSecond` を得た（sorry 検査 984 件、すべて非依存）。
**claim 本体の Lean は未了**なので本文の `lean` 宣言はまだ付けない。次 tick は実数評価の
上下評価を Lean 化し、具体版・必要十分版・導出を閉じる。式変形統一では姉妹側
「指数行列による共役の交換子級数展開」の級数展開・反復交換子・共役写像の三計算を、
一続きの等号と行末根拠へ揃えた。

2026-08-15 の tick 272 は、レビューで前 tick の「開境界長方形の接合不等式」の本文と SageMath
（80 組）が一致していることを確認し（修正無し）、そのあと同セクションの Lean を論法ごとに
「接合の全単射」「破れボンド数の接合面分解」「実数評価の上下評価」の三つへ割り直し、先頭の
「接合の全単射」の Lean 具体版 `lean/Ising2DLambda/ThermodynamicLimit/OpenRectangleGluing.lean`
を完成させた。第一の座標方向の制限 `openConfigSplitFirstLeft/Right`（$\rho_L,\rho_R$）と接合
`openConfigGlueFirst`（$\rho_{\sigma,\tau}$）、第二の座標方向の対応物を人手証明と 1 対 1 に写し、
「二つの構成を順に行うと各頂点で元の値に戻る」を戻りの等式六補題
（`splitFirstLeft_glueFirst` 等）として示し、全単射 `openConfigGlueEquivFirst/Second` を得た
（sorry 検査 978 件、すべて非依存）。**claim 本体の Lean は未了**なので本文ブロックへの `lean`
宣言はまだ付けない。次 tick は「破れボンド数の接合面分解」の Lean（接合後の辺集合の三分割と
個数の加法）を進める。式変形統一では姉妹側「$\check Z,\check Y$ についてのテイラー係数の抽出」
の (h1.y)(h2.z)(h2.y) の三鎖を、(h1.z) と同じ粒度（場合分け形の行と「和の外へ出す」行を持つ
一行一等号）へ開いた。

2026-08-15 の tick 271 は、レビューで前 tick の「開境界長方形の分配多項式」の五定義について、
本文・SageMath・Lean 具体版の頂点条件、向き付き辺と端点写像、配位、破れボンド数、分配多項式、
数え上げ補題 4 件が一致し、入口 import と sorry 非依存検査も揃っていることを確認した（修正無し）。
そのあと「開境界長方形の接合不等式」を記述と SageMath まで進めた。正の実数での評価を明示的に
定義し、第一・第二の座標方向の接合について、接合後の配位と二つの配位の組との全単射、破れボンド数の
「二つの内部＋接合面」への分解を示した。接合面の破れ辺数は横方向の接合で $0$ 以上 $b$ 以下、
縦方向の接合で $0$ 以上 $a$ 以下なので、$0<t\le1$ と $1\le t$ の各場合に接合前の分配多項式の積を
挟む上下評価を得た。SageMath（`sagemath/check/open-rectangle-gluing-inequality`）は
$a,b,c\in\{1,2\}$ と正の有理点 5 点で両方向 80 組を厳密検査した。**Lean は未着手**で、次 tick は
この接合不等式の Lean 具体版・必要十分版・導出を進める。式変形統一では姉妹側
「$\check Z,\check Y$ についての $\cosh,\sinh$ の展開係数への変換」の二補題に残っていた
生成子のスカラー倍と虚数単位の冪の圧縮鎖を、一行一等号と行末根拠へ開いた。

2026-08-15 の tick 270 は、レビューで前 tick の「開境界長方形の分配多項式」の五定義と
SageMath（108 件）が一致していることを確認し（修正無し）、そのあと Lean 具体版
`lean/Ising2DLambda/ThermodynamicLimit/OpenRectangle.lean` を完成させ、セクションを完了した。
五定義（`OpenVertex`・`OpenEdgeH/V/OpenEdge` と端点写像 `openBoundary0/1`・`OpenConfig`・
`openBrokenBondSet/openBrokenBondCount`・`openPartitionPolynomial`）を人手証明と 1 対 1 に写し
（`Fin a × Fin b` が本文の「$i<a$ かつ $j<b$ の $(i,j)\in\mathbb{N}\times\mathbb{N}$」の直訳、
向きの印を付けた直和は直和型 `⊕`、剰余類は使わない）、数え上げ補題 4 件
（頂点数 $ab$・辺数 $a(b-1)+(a-1)b$・配位数 $2^{ab}$・破れボンド数の上界）を sorry 検査へ
登録した（972 件、すべて sorryAx 非依存）。**定義ブロックには主張が無いので、必要十分版・導出は
付けない**（周期境界の定義 4 件と同じ扱い。tick 3 の前例に従う）。式変形統一では姉妹側
「$\check Z,\check Y$ についての $n$ 重交換子」（`evensectorT_002_claim_nesting_commutator`）の
八つの帰納法の鎖へ、先頭行（定義と帰納法の仮定の代入）と最終行（スカラー倍の交換）の行末根拠を
補い、二重等号の行を一行一等号へ開いた。次の本文は「開境界長方形の接合不等式」
（横または縦に接ぐときの積との比較）、次の統一は同じ偶セクター章の後続から続ける。

2026-08-15 の tick 269 は、レビューで前 tick の「上限の一意性」の本文・SageMath・Lean 三本が
同じ論法を辿っていることを確認した（修正無し）。そのあと「自由エネルギー密度の極限の存在」を、
開境界長方形の分配多項式・長方形の接合不等式・周期境界との差の境界評価・極限の導出へ割り直した。
上限の存在と上限への任意近接だけでは任意の数列の収束を導けないためである。先頭の
「開境界長方形の分配多項式」を記述と SageMath まで進め、頂点・辺・配位・破れボンド数・
分配多項式を五ブロックで定義した。すべて有限集合・$\mathbb{N}$・$\mathbb{Z}[x]$ で閉じ、
$\mathbb{R}/\mathbb{C}$ は使わない。SageMath（`sagemath/check/open-rectangle-partition-polynomial`）は
$a,b\in\{1,2,3\}$ の全長方形で、頂点数・辺数・配位数・端点・破れボンド数・係数和を 108 件
厳密検査した。**Lean は未着手**で、次 tick は五定義の Lean 具体版・必要十分版・導出を進める。
式変形統一では姉妹側「$V^{(+)}$ と $T_{(V^{(+)})}$ の定義」の平方根の鎖へ、同類項の加法という
行末根拠を補った。

2026-08-15 の tick 268 は、レビューで前 tick の「上限への任意近接」の Lean 三本が本文と一対一に
揃っていることを確認し（修正無し）、そのあと「上限の一意性（記法 $\sup$ の正当化）」を
記述・SageMath・Lean 具体版・必要十分版まで一 tick で完成させ、四層を揃えた（反対称性一本の
小セクションのため一気に進めた）。一ブロック `claim_real_set_supremum_unique`（$u_1,u_2$ が
ともに $S$ の上限なら $u_1=u_2$。両向きの $\le_{\mathbb{R}}$ を最小性の適用で取り、略記の展開と
三分律の場合の除外で閉じる。完備性は使わない。これで `claim_free_energy_density_supremum_exists`
の記法 $\sup\Psi_t$ が正当化された）。SageMath（`sagemath/check/real-set-supremum-uniqueness`）は
$\mathbb{Q}$ の厳密比較のみで 74 件（上限の述語の量化は有限モデルでは周囲集合への制限であることを
overview に明記）。Lean は具体版 `realSetSupremum_unique`、必要十分版
`leastUpperBound_unique_necSuf`（実数を外し半順序だけを残した。`lt_or_eq_of_le` が反対称性を
要するため `PartialOrder` が下限で、具体版が使った三分律の全体＝線形順序は不要と判明）、導出
`realSetSupremum_unique_from_necSuf`。本文の「この先に書くこと」とセクション表から当該項目を
消した。式変形統一では姉妹側「$H_1^{(+)},H_2$ を $\check Z,\check Y$ で表す」の二つの鎖
（$H_2$ の鎖と $H_1^{(+)}$ の鎖）に欠けていたスカラー $1/M$ と $M$ の相殺の行末根拠を補った。
次の本文は「自由エネルギー密度の極限の存在」（残るは $\varepsilon$ を固定したときある $N$ 以降の
すべての $L$ で近づくことの証明。道具は未定。列 $\psi_L(t)$ は $L$ について単調とは限らないので、
劣加法性や部分列の議論を検討する）。次の統一は同じ偶セクター章の後続から続ける。

2026-08-15 の tick 267 は、レビューで前 tick の上界・最小上界の二定義と「上限への任意近接」の
本文・SageMath が一致していることを確認し（修正無し）、そのあと Lean 具体版
`freeEnergyDensity_supremum_approximation`、必要十分版
`rangeValue_supremum_approximation_necSuf`、導出
`freeEnergyDensity_supremum_approximation_from_necSuf` を完成させ、四層を揃えた。具体版は本文の
$u-\varepsilon<u$、最小性から $u-\varepsilon$ が上界でないことを導く背理法、非上界から反例を
取る段、値集合を格子サイズの証人へ展開する段を同じ順で辿る。必要十分版は自由エネルギー密度・
実数・減法を外し、線形順序上の値域・上限・上限より小さい元だけを残した。式変形統一では姉妹側
「$\check Z,\check Y$ から $Z_j,Y_j$ を復元する」の復元式の最終行へ、スカラー $1/M$ と $M$ の
相殺という行末根拠を補った。次の本文は「上限の一意性（記法 $\sup$ の正当化）」、次の統一は
偶セクターの後続証明から続ける。

2026-08-15 の tick 266 は、レビューで前 tick の「自由エネルギー密度の値集合の上限の存在」の
Lean 三本が本文と一対一に揃っていることを確認したうえで、本文側の二つの欠陥——「最小上界」が
未定義のまま「実数の完備性への脱出の宣言」と上限存在の主張に使われていたこと、同宣言の
「$\le_{\mathbb{R}}$ の略記の初出はここ」が実際の初出（それより前の行）と食い違っていたこと——を
見つけて直した。そのあと「自由エネルギー密度の極限の存在」から一論法で閉じる片を
「上界・最小上界の定義と上限への任意近接」として切り出し、記述と SageMath まで進めた。
三ブロック: `def_real_set_upper_bound`・`def_real_set_supremum`（上界と最小上界を述語として定義。
存在も一意性もまだ主張しない。一意性＝記法 $\sup$ の正当化は後続セクションとしてセクション表へ
追加した）と `claim_free_energy_density_supremum_approximation`（$u$ を $\Psi_t$ の上限とすると
任意の $\varepsilon>0$ に対しある $L\ge1$ で $u-\varepsilon<_{\mathbb{R}}\psi_L(t)$。順序の三分律を
realEscape で追加宣言し、最小性からの背理法一本と、上界でないことの展開で閉じる）。略記
$\le_{\mathbb{R}}$ の宣言は「実数体への脱出の宣言」へ移した。SageMath
（`sagemath/check/free-energy-density-supremum-approximation/`）は全て $\mathbb{Q}$ の厳密比較で
154 件（実対数の値の比較は $Z_a(t)^{b^2}\le Z_b(t)^{a^2}$ の $\mathbb{Q}$ 比較へ置き換え、
浮動小数点・ball を使わない。真の上限は有限標本で検査できないと明記）。**Lean は未着手**で、
次 tick はこの三ブロックの Lean（具体版・必要十分版・導出）を進める。式変形統一では姉妹側
「$H$ と $\check Z,\check Y$ の交換子」（`commutator_of_H_and_check_Z_Y`、偶セクターのモード）の
三つの鎖の最終行（$=2Z_j$・$=2Y_m$・$=2(-Y_M)$）に欠けていた行末根拠を補い、単位行列の消去と
同類項の統合の圧縮を開いた。次の統一は同じ偶セクターの章の後続の根拠なし連鎖から続ける。

2026-08-15 の tick 265 は、レビューで前 tick の「自由エネルギー密度の値集合の上限の存在」の
本文と SageMath が一致していることを確認し（修正無し）、そのあと Lean 具体版
`freeEnergyDensityValueSet_has_supremum`、必要十分版
`indexedValueSet_has_supremum_necSuf`、導出
`freeEnergyDensityValueSet_has_supremum_from_necSuf` を完成させ、四層を揃えた。具体版は値集合の
非空性を格子サイズ $1$ で示し、一様上界を与え、実数の完備性を一度だけ適用する本文の三段を
同じ順で辿る。必要十分版は格子・自由エネルギー密度・実数を外し、添字付き値集合の証人、
一様上界、空でない上に有界な集合へ上限を与える性質だけを残した。式変形統一では姉妹側
「$V'$ のトレース」のフェルミオン数演算子の積和を指数関数の有限積へ分解する鎖の先頭行に、
各二値成分の独立な選択による有限積の展開という行末根拠を補った。次の本文は
「自由エネルギー密度の極限の存在」。次の統一は同じ固有値章の後続から続ける。

2026-08-15 の tick 264 は、レビューで前 tick の「自由エネルギー密度の上からの評価」の Lean 三本
（具体版・必要十分版・導出）が本文と一対一に揃っていることを確認し（修正無し）、そのあと
「自由エネルギー密度の極限の存在」から完備性の適用一発で閉じる部分を
「自由エネルギー密度の値集合の上限の存在」として切り出し、記述と SageMath まで進めた。二ブロック:
`def_free_energy_density_value_set`（値集合 $\Psi_t=\{\psi_L(t)\mid L\in\mathbb{N},\,L\ge1\}$ の
内包的定義。量化子を明示）と `claim_free_energy_density_supremum_exists`（$\Psi_t$ は空でなく
（証人 $L=1$）、上に有界（上界 $M_t$ は上からの評価の右辺で $L$ に依らない）なので、宣言済みの
完備性「上限の存在」により $\sup\Psi_t\in\mathbb{R}$ が存在する。**完備性を実際に使うのは本文で
この一箇所が初**であり、realEscape にそれを書いた）。SageMath
（`sagemath/check/free-energy-density-supremum/`）は非空性の証人を厳密に、上界性を ball の分離で
厳密に、最小上界の性質は有限部分集合のモデルで検査し、完備性そのものは有限標本では検査できない
ことを overview に明記した（合計 50 件）。**Lean は未着手**で、次 tick はこの二ブロックの Lean
（具体版・必要十分版・導出）を進める。残る「自由エネルギー密度の極限の存在」は列が上限へ
近づくことの証明で、道具（劣加法性・単調性など）は未定。式変形統一では姉妹側
「$iH$ が実対称であること」（固有値章）の Step 1 の $Z_mY_m$ と Step 2 の $Y_mZ_{m+1}$ の鎖の
先頭行に定義適用の行末根拠を補った。次の統一は同じ固有値章の残り（フェルミオン数演算子の積和の
指数関数の因子分解の鎖の先頭行、`009_eigenvalues_of_V.ts` 1547 行付近）から続ける。

2026-08-15 の tick 263 は、「自由エネルギー密度の上からの評価」の Lean 具体版
`freeEnergyDensity_le_upperBound`、必要十分版 `scaled_map_upperBound_necSuf`、導出
`freeEnergyDensity_le_upperBound_from_necSuf` を完成させ、四層を揃えた。具体版は本文の
上界・実対数の弱い単調性・積と自然数冪の対数・有理係数の相殺を同じ順で辿り、必要十分版は
上界の写像による移送・非負尺度作用・二項の像の分解・係数相殺だけを残した。レビューでは、
前 tick の準備第四にあった四等号の圧縮を四段の鎖へ直し、前進前に main へ反映した。
式変形統一では姉妹側「数演算子どうしの可換性」の四つの反交換関係を根拠付きへ開いた。
次の本文は「自由エネルギー密度の極限の存在」。

2026-08-15 の tick 262 は、レビューで前 tick の「実対数の自然数冪」の Lean 三本
（具体版・必要十分版・導出）が本文と一対一に揃っていることを確認し（修正無し）、そのあと
「自由エネルギー密度の上からの評価」を記述と SageMath まで進めた。一ブロック:
`claim_free_energy_density_upper_bound`
（$\psi_L(t)\le_{\mathbb{R}}\log_{\mathbb{R}}(\iota_{\mathbb{Q}\to\mathbb{R}}(2))+\iota_{\mathbb{Q}\to\mathbb{R}}(2)\cdot\log_{\mathbb{R}}(1+t)$。
右辺は $L$ に依らない）。準備は冪の正値性・$\iota_{\mathbb{Q}\to\mathbb{R}}$ の正値性・
実対数の弱い単調性（狭義単調性と相等の場合分けから導く）・体準同型と自然数冪
（$\iota(q^{n})=\iota(q)^{n}$ の帰納法）・分配多項式の値の上界の実対数（弱い単調性の適用）の
五つ。本体は $\psi_L(t)$ から始める十二行の一続きの鎖で、実対数の自然数冪で二つの冪を開き、
$\iota$ の乗法性で $\frac{1}{L^2}$ を相殺する。完備性・極限は使わない。SageMath
（`sagemath/check/free-energy-density-upper-bound/`）は可算側を厳密に、主張本体の不等式は
ball の分離（差の下端が正）で厳密に、実対数の分解の等式だけ ball の整合で検査した
（合計 188 件）。**Lean は未着手**で、次 tick はこの一片の Lean（具体版・必要十分版・導出）を
進める。次の本文はその後「自由エネルギー密度の極限の存在」（完備性を使う。宣言は済んだ）。
式変形統一では姉妹側「フェルミオン数演算子の冪等性（$n_\mu^2=n_\mu$）」の鎖の先頭行
（数演算子の定義の適用）に欠けていた行末根拠を補った。次の統一は固有値の章の後続の
根拠なし連鎖から続ける。

2026-08-15 の tick 261 は、レビューで前 tick の「実対数の自然数冪」の本文と SageMath を
突き合わせ、冪の正値性・基底四段・帰納段七段・有限標本検査の限界が一致しているため修正不要と
確認した。そのあと Lean 具体版 `realLogarithm_naturalPower`、必要十分版
`naturalPower_map_necSuf`、導出 `realLogarithm_naturalPower_from_necSuf` を完成させ、四層を揃えた。
具体版は正値性を定義域の証拠として保持し本文と同じ帰納法を辿る。必要十分版は実数・順序・対数・
冪を外し、二つの再帰等式、乗法を加法へ移す等式、自然数埋め込みと尺度作用の零・一・加法保存だけを
残した。式変形統一では姉妹側「臨界条件と $\gamma_2$ の零点の対応」の正値性・双曲線恒等式・
最終の同値鎖を一行一関係と行末根拠へ開いた。次の本文は「自由エネルギー密度の上からの評価」。

2026-08-15 の tick 260 は、レビューで前 tick の「分配多項式の値の上からの評価」の Lean 三本が
本文と一対一に揃っていることを確認したうえで、本文ブロック
`claim_partition_value_upper_bound` に lean 宣言（Lean 名の対応付け）が欠けていた欠落を補い、
前進前に main へ反映した。そのあと「実対数の自然数冪」を記述と SageMath まで進めた。一ブロック:
`claim_real_log_natural_power`
（$\log_{\mathbb{R}}(u^{n})=\iota_{\mathbb{Q}\to\mathbb{R}}(n)\cdot\log_{\mathbb{R}}(u)$。
指数についての帰納法一本。基底は実対数の 1 における値 `claim_real_log_one`、歩みは乗法を加法へ
移す性質・分配則・体準同型の加法保存だけを使い、狭義単調性・完備性は使わない。自然数倍は
$\iota_{\mathbb{Q}\to\mathbb{R}}(n)$ を通して書き、記号の濫用を避けた。準備は冪の正値性のみ）。
SageMath（`sagemath/check/real-log-natural-power/`）は可算側（冪の正値性・分配則・$\iota$ の
加法保存のモデル）を厳密に、実対数に触れる行だけ ball の整合で検査した（合計 451 件）。
**Lean は未着手**で、次 tick はこの一片の Lean（具体版・必要十分版・導出）を進める。
次の本文はその後「自由エネルギー密度の上からの評価」（分配多項式の値の上界に実対数を施し、
この冪の等式で $L$ に依らない上界へ落とす）。式変形統一は姉妹側の転送行列章の後続から続ける。

2026-08-15 の tick 259 は、レビューで前 tick の「分配多項式の値の上からの評価」の本文と
SageMath を突き合わせ、四つの準備・五段の不等式鎖・有限標本検査の範囲が一致しているため
修正不要と確認した。そのあと Lean 具体版 `partitionPolynomial_eval_real_le_upperBound`、
必要十分版 `sum_pow_le_uniform_bound_necSuf`、導出
`partitionPolynomial_eval_real_le_upperBound_from_necSuf` を完成させ、四層を揃えた。具体版は
底の単調性と指数の単調性を本文と同じ帰納法で示し、各配位の項を二度比較して定数の有限和へ
まとめる。必要十分版は格子・配位・実数を外し、有限和と二つの冪の比較だけを残した。
式変形統一では姉妹側「$T_{(V)}$ の $\hat Z,\hat Y$ への作用」の共役作用・行列積・四成分の計算へ
行末根拠を補い、一行に複数の等号があった箇所を開いた。次の本文は「実対数の自然数冪」。

2026-08-15 の tick 258 は、レビューで前 tick の「自由エネルギー密度の下からの評価」の Lean 三本
（具体版・必要十分版・導出）を本文と突き合わせ、修正不要と確認した。そのあと
「自由エネルギー密度の上からの評価」を「分配多項式の値の上からの評価」「実対数の自然数冪」
「自由エネルギー密度の上からの評価」の三片へ割り直し（冪の比較の帰納法・実対数の冪の帰納法・
両者の合成と、論法が複数あるため）、最初の一片を記述と SageMath まで進めた。一ブロック:
`claim_partition_value_upper_bound`（$Z_L(t)\le_{\mathbb{R}}\iota_{\mathbb{Q}\to\mathbb{R}}
(2^{L^2})\cdot(1+t)^{2L^2}$。底を $1+t$ に取り $t\le1$／$1\le t$ の場合分けを回避。準備は
冪の正値性・底の単調性・指数の単調性・定数の有限和の四つで、いずれも帰納法。順序の議論のみで
実対数・完備性は使わない）。SageMath（`sagemath/check/partition-value-upper-bound/`）は
すべて $\mathbb{Q}$ の厳密比較で浮動小数点を使わない（合計 766 件）。**Lean は未着手**で、
次 tick はこの一片の Lean（具体版・必要十分版・導出）を進める。式変形統一では姉妹側
「$K_2$ と $K_2^*$ の双対関係」の二つの鎖に残っていた根拠なしの等号 4 行ずつへ、
指数表示の代入・$\tanh$ の定義・通分・記号の定義の行末根拠を補った。次の式変形統一は
同じ転送行列章の後続の根拠なし連鎖から続ける。

2026-08-14 の tick 257 は、レビューで前 tick の「自由エネルギー密度の下からの評価」の本文と
SageMath を突き合わせ、各段と検証範囲が一致しているため修正不要と確認した。そのあと Lean 具体版
`allPlusConfig_brokenBondCount_eq_zero`・`freeEnergyDensity_nonnegative`、必要十分版
`scaled_monotone_sum_nonnegative_necSuf`、導出 `freeEnergyDensity_nonnegative_from_necSuf` を完成させ、
四層を揃えた。具体版は全て正の配位の破れボンド数を零と示し、その一項による $1\le Z_L(t)$、
実対数の単調性による $0\le\varphi_L(t)$、非負の有理係数との積を本文と同じ順に辿る。
必要十分版は格子・配位・破れボンド数を外し、有限和の選んだ指数が零であること、正の冪、
一で零になる狭義単調写像、非負倍率だけを残した。式変形統一では姉妹側「直積作用の計算」の
二つの三段鎖へ、直積写像の定義・二つの共役作用の行列表示・二列を行列へ並べる操作の行末根拠を
補った。次の本文は「自由エネルギー密度の上からの評価」。次の式変形統一は同じ転送行列章の
後続の根拠なし連鎖から続ける。

2026-08-14 の tick 256 は、レビューで、前 tick が「補った」と記録した $L\in\mathbb{N}$ の帰属が
実際には文書冒頭の格子の定義にだけ入っており、「有限系の実自由エントロピー」
`def_finite_real_free_entropy` と「自由エネルギー密度」`def_free_energy_density` の定義は
「各 $L\ge1$」のままだったことを見つけ、両ブロックへ帰属を補って前進前に main へ反映した。
そのあと「自由エネルギー密度の極限の存在」から順序の議論だけで閉じる部分を
「自由エネルギー密度の下からの評価」として切り出し、記述と SageMath まで進めた。三ブロック:
`def_constant_plus_configuration`（全て正の定数配位 $\sigma_+$。正値性の証明中の準備を参照可能な
定義として独立させた）、`claim_constant_plus_breaks_no_bond`（$b(\sigma_+)=0$。可算側 $\mathbb{N}$
で閉じる四段の鎖）、`claim_free_energy_density_nonnegative`（$0\le_{\mathbb{R}}\psi_L(t)$。準備は
1 項分離による $1\le_{\mathbb{R}}Z_L(t)$、実対数の 1 における値と狭義単調性による
$0\le_{\mathbb{R}}\varphi_L(t)$、$0<1/L^2$ の埋め込みの正値性。完備性は使わない）。SageMath
（`sagemath/check/free-energy-density-lower-bound/`）は可算側を厳密に、実対数に触れる不等式だけ
ball の分離で検査した（合計 165 件）。**Lean は未着手**で、次 tick はこの三ブロックの Lean
（具体版・必要十分版・導出）を進める。式変形統一では姉妹側「ホロノミック量子場 p142 下段」の
二つの $V_2$ 共役鎖に残っていたスカラー相殺の圧縮行を行末根拠付きの四行
（スカラー倍の行列の逆元・スカラーの可換・スカラーとその逆元の相殺・級数展開）へ開き、
鎖の後の段落にあった根拠を鎖の前の準備へ移した。次の式変形統一は同じ転送行列章の後続の
根拠なし連鎖から続ける。

2026-08-14 の tick 255 は、レビューで前 tick の自由エネルギー密度の定義に
$L\in\mathbb{N}$ の帰属が明記されていない欠落を見つけ、本文へ補って前進前に main へ反映した。
そのあと「自由エネルギー密度と極限の言明の定式化」の Lean 具体版・必要十分版・導出を完成させ、
四層を揃えた。具体版は正の格子サイズを部分型で保持し、有理数 $1/L^2$ の実数埋め込みによる
自由エネルギー密度、絶対値を使わない二側極限述語、空でなく上に有界な実数集合の上限の存在を
実装した。必要十分版は順位付き添字上の二側極限述語と上限存在性だけを残し、導出で具体版へ
特殊化した。式変形統一では姉妹側「ホロノミック量子場 p142 下段」の四つの共役計算に残っていた
根拠なしの等号へ行末根拠を補った。次の本文は「自由エネルギー密度の極限の存在」。次の式変形統一は
同じ証明のスカラー相殺を含む圧縮行から続ける。

2026-08-14 の tick 254 は、レビューで前 tick の「実対数と有限系の実自由エントロピー」の
Lean 三本を本文と突き合わせ、修正不要と確認した。そのあと「熱力学極限」章のセクション
「自由エネルギー密度の極限」を「自由エネルギー密度と極限の言明の定式化」と
「自由エネルギー密度の極限の存在」へ割り直し（定式化は宣言済みの順序体の性質だけで書けるが、
存在の証明は完備性という別の道具を要するため）、前者を記述と SageMath まで進めた。
三ブロック: `def_free_energy_density`（$\psi_L(t):=\iota_{\mathbb{Q}\to\mathbb{R}}(1/L^2)
\cdot\varphi_L(t)$。$1/L^2\in\mathbb{Q}$ は可算側で確定させ、実数の除法を使わない）、
`def_free_energy_density_limit_statement`（$f$ が極限であることの定式化。絶対値を導入せず
$-\varepsilon<_{\mathbb{R}}\psi_L(t)-f<_{\mathbb{R}}\varepsilon$ の 2 不等式で書く。
存在はまだ主張しない）、`remark_real_completeness_escape`（完備性への脱出の宣言。使う形を
「空でなく上に有界な部分集合は上限を持つ」の一つに限る。宣言のみでまだ使わない。
$\le_{\mathbb{R}}$ の略記の初出もここ）。SageMath（`sagemath/check/free-energy-density/`）は
可算側と $t=1$ での $\psi_L(1)=\log 2$（$L$ に依らない）を記号計算で厳密に、実対数に触れる
検査だけ ball 算術で検査した（合計 50 件）。**Lean は未着手**で、次 tick はこの三ブロックの
Lean（具体版・必要十分版・導出）を進める。式変形統一では、指示の続き位置「$Z,Y$ から
和・スカラー倍・積だけで複素行列がすべて得られる」は既定の形を満たすと確認したうえで、
後続で最初に根拠なし連鎖が残る姉妹側「$V_2$ が $\mathcal{P}_M$ を保たないこと」（Step 4）の
四段鎖を直した（根拠の無い三段へ行末根拠を足し、鎖の後の段落にあった
$\sigma^z\sigma^x=i\sigma^y$ の成分計算を鎖の前の準備へ移した）。次の式変形統一は
同じ証明の後続（$\hat Z^{(\pm)}_\mu$ への共役の計算以降）の根拠なし連鎖から続ける。

2026-08-14 の tick 253 は、レビューで前 tick の「実対数と有限系の実自由エントロピー」の
本文と SageMath を突き合わせ、修正不要と確認した。そのあと Lean 具体版
`realLogarithm_mul`・`realLogarithm_strictMono`・`realLogarithm_one` と有限系の実自由
エントロピーの定義、必要十分版 `map_one_eq_zero_necSuf`、導出
`realLogarithm_one_from_necSuf` を完成させ、四層を揃えた。具体版は正の実数を部分型で保持し、
本文の六段で $\log_{\mathbb{R}}(1)=0$ を示す。必要十分版は実数・順序・対数を外し、乗法単位元、
加法群、$1\cdot1$ での乗法加法性だけを要求する。次の本文は「自由エネルギー密度の極限」。
式変形統一では姉妹側「$\hat Z,\hat Y$ から $Z,Y$ の復元」の指数和の直交性と Fourier 変換の
定義の適用箇所へ行末根拠と直後のラベル参照を揃えた。次は「$Z,Y$ から和・スカラー倍・積だけで
複素行列がすべて得られる」以降から続ける。

2026-08-14 の tick 252 は、レビューで前 tick の「正の実数での分配多項式の値は正である」の
Lean 三本（具体版・必要十分版・導出）を本文と突き合わせ、修正不要と確認した。そのあと
「熱力学極限」章のセクション「実対数と有限系の実自由エントロピー」を記述と SageMath まで
進めた。三ブロック: `remark_real_logarithm`（実対数 $\log_{\mathbb{R}}:\mathbb{R}_{>0}\to
\mathbb{R}$ を既知の数学として引く。使う性質は「乗法を加法へ移す」「狭義単調」の二つに限り、
構成・連続性・全射性・微分可能性は使わない。$\Lambda$ 側の $\log$ とは別の写像で同一視せず、
関係は必要になる箇所で $\Lambda\to\mathbb{R}$ の写像を定義してから述べる）、
`claim_real_log_one`（$\log_{\mathbb{R}}(1)=0$。加法性と順序体の性質だけからの六段の鎖）、
`def_finite_real_free_entropy`（$\varphi_L(t):=\log_{\mathbb{R}}(Z_L(t))$。well-defined 性は
`claim_partition_value_positive_at_positive_real` から。$\Phi_L$ とは別の写像と明記）。
呼称は $\Lambda$ 側 $\Phi_L$ の「自由エントロピー」に揃え「実自由エントロピー」とした
（台帳の旧名は「実自由エネルギー」）。SageMath（`sagemath/check/finite-real-free-entropy/`）は
実対数に触れる検査だけ RealBallField(256) を使い（不等式は ball の分離で厳密、等式は差の
ball が 0 を含む整合検査にとどまる。理由は overview に記録）、可算側（$Z_L(t)$ の値・正値性、
$\log(1)=0$ の記号計算）は厳密に検査した（合計 98 件）。**Lean は未着手**で、次 tick は
この三ブロックの Lean（具体版・必要十分版・導出）を進める。次の本文は
「自由エネルギー密度の極限」（完備性を使う箇所を宣言する）。式変形統一では、姉妹側
「指数関数の和とクロネッカーのデルタの関係」は既定の形を満たすと確認し、次の
「$H_1,H_2$ を $\hat Z,\hat Y$ で表す」の証明で、日本語を挟んで 2 つに割れていた鎖を
1 つへつなぎ、分割行と両鎖の先頭行に欠けていた行末根拠を足した。次の式変形統一は
「$\hat Z,\hat Y$ から $Z,Y$ の復元」以降の根拠なし連鎖から続ける。

2026-08-14 の tick 251 は、レビューで前 tick の「実数体への脱出の宣言」と「正の実数での
分配多項式の値は正である」の本文・SageMath を突き合わせ、修正不要と確認した。そのあと
同セクションの Lean 具体版 `partitionPolynomial_eval_real_pos`、必要十分版
`sum_pow_pos_by_separating_term_necSuf`、導出
`partitionPolynomial_eval_real_pos_from_necSuf` を完成させ、四層を揃えた。具体版は本文と同じく、
正の実数の冪を指数について帰納し、全て正の配位の一項を有限和から分離する。必要十分版は
格子・配位・破れボンド数・実数を外し、有限添字型、選んだ一項、自然数指数写像、狭義順序半環
だけを残した。入口 import、本文対応、sorry 非依存検査への登録も完了した。次の本文は
「実対数と有限系の実自由エネルギー」。式変形統一では姉妹側「$V_1$ の固有空間への制限」の
極限一意性を散文中に圧縮していた箇所を、三角不等式・二つの収束・ノルム零からの一致を
一行ずつ根拠付きで示す鎖へ開いた。次は「指数関数の和とクロネッカーのデルタの関係」以降から
続ける。

2026-08-14 の tick 250 は、レビューで前 tick の「詰め寄りの述語の定式化」の Lean 三本
（具体版・必要十分版・導出）を本文と突き合わせ、修正不要と確認した。そのあと
「熱力学極限」章のセクション「自由エネルギー密度・零点密度」を「実数体への脱出の宣言と
正の実数での値の正値性」「実対数と有限系の実自由エネルギー」「自由エネルギー密度の極限」
「零点密度」の四片へ割り直し、最初の一片を記述と SageMath まで進めた。二ブロック:
`remark_real_field_escape`（文書で初めて $\mathbb{R}$ を導入する宣言。使う性質を順序体の
性質と単射 $\iota_{\mathbb{Q}\to\mathbb{R}}$ に限って列挙し、完備性・極限・実対数は
含めない——使うブロックが現れた時点で realEscape に理由を書いて追加する）と
`claim_partition_value_positive_at_positive_real`（$0<_{\mathbb{R}}t$ なら
$0<_{\mathbb{R}}Z_L(t)$。代入の環準同型性で配位の和へ開き、定数写像 $\sigma_+$ の一項を
分離し、各項の正値性は指数についての帰納法）。SageMath
（`sagemath/check/partition-value-positive-at-positive-real/`）は $L\in\{1,2,3\}$ ×
正の有理点 7 点で式変形の各行を厳密検査した（3773 件。$t$ の標本が有理点である理由と
$L\le3$ に限る理由は overview に注記）。**Lean は未着手**で、次 tick はこの二ブロックの
Lean（具体版・必要十分版・導出）を進める。式変形統一では姉妹側「$V_1,V_2$ を
$Z,Y,\varepsilon$ で表す」証明 Step 4 最終行 $=-i\,\sigma_m^x$ に欠けていた行末根拠
$(\because\ \text{Step 1 の }\sigma_m^x\text{ の表示})$ を足した。次の式変形統一は
同じ転送行列章のさらに後続の証明の根拠なし連鎖から続ける。

2026-08-14 の tick 249 は、レビューで前 tick の「詰め寄りの述語の定式化」の本文と
SageMath を突き合わせ、検査範囲が $L\in\{1,2\}$ なのに二つの関数コメントだけ
$L=1,2,3$ と誤記していたため、前進前に修正して main へ反映した。そのあと Lean 具体版
`zeroPinchingPredicate`・`phaseTransitionCountableStatement`・
`distanceSquaredToPositiveRational_ne_zero`、必要十分版
`distance_ne_zero_of_zero_implies_equal_necSuf`、導出を完成させ、四層を揃えた。
具体版は正の有理数と正の格子サイズを部分型で保持し、距離の二乗の非零性を本文と同じく
零性同値と「正の有理点は Fisher 零点でない」からの背理法で示す。必要十分版は距離の公式・
体・順序・有理数・代数的数を外し、零性から二点の一致が従うことと比較点の非所属だけを要求する。
式変形統一では姉妹側「$V_1,V_2$ を $Z,Y,\varepsilon$ で表す」の指数表示に残っていた
根拠なしの等号を、一行一等号と行末根拠を持つ鎖へ開いた。次の式変形統一は同じ転送行列章の
後続証明から続ける。
次の本文は「熱力学極限」章の最初のセクション（`realEscape` を具体的に書く）。

2026-08-14 の tick 248 は、レビューで前 tick の「零点と有理点の距離の二乗」の Lean 三本
（具体版・必要十分版・導出）を本文と突き合わせ、修正不要と確認した。そのあとセクション
「詰め寄りの述語の定式化」を記述と SageMath まで進めた。三ブロック:
`def_zero_pinching_predicate`（$\varepsilon\in\mathbb{Q}_{>0}$ に対し、ある $L\ge1$、
$\xi\in\mathcal{F}_L$、$q\in\mathbb{Q}_{>0}$ が存在して
$\mathrm{dsq}(\xi,q)<_R\varepsilon\cdot\varepsilon$。距離そのものでなく平方どうしを比べる
理由——非負元の平方根の存在をまだ主張していない——を本文に明記）、
`claim_distance_positive_on_fisher_zeros`（$\xi\in\mathcal{F}_L$、$q\in\mathbb{Q}_{>0}$ なら
$\mathrm{dsq}(\xi,q)\ne0$。零性同値 `claim_distance_squared_zero_iff_equal` と
`claim_positive_rational_not_fisher_zero` からの背理法）、
`def_phase_transition_countable_statement`（全称 $\varepsilon$ の言明の定式化。まだ主張しない）。
本文末尾「この先に書くこと」から済んだ「零点の詰め寄り」の項目を消した。SageMath
（`sagemath/check/zero-pinching-predicate/`）は $L\in\{1,2\}$ の全 Fisher 零点 × 正の有理点
6 点 × $\varepsilon$ 5 点で述語の決定可能性 240 件・非零性 48 組を厳密検査し、$\varepsilon$
ごとの証人の有無を記録した（$L=3$ は次数 12 の exactify が資源上限で終わらないため除外。
overview に注記。実測: 素の probe が 300 秒でも終わらなかった）。**Lean は未着手**で、
次 tick はこの三ブロックの Lean（具体版・必要十分版・導出）を進める。次の本文は
「熱力学極限」章の最初のセクション（`realEscape` を具体的に書く）。
式変形統一では、姉妹側「トレース冪の挟み撃ち」に残存圧縮が無いことを確認したうえで、
姉妹側「$\cos(\arctan(x)),\ \sin(\arctan(x))$」の根拠なしの圧縮鎖を行末根拠付きの
九段・二段の鎖へ開いた。次の式変形統一は、計算公式の章の残りの根拠なし連鎖
（`000_calculation_formulae_00_09.ts` の $Z_m$ 表示や転送行列章など、statement 内の
定義的な列挙を除く証明中の連鎖）から続ける。

2026-08-14 の tick 247 は、レビューで前 tick の「零点と有理点の距離の二乗」の本文と
SageMath を突き合わせ、定義域・値域、一意表示、零性同値の二方向、有限標本検査の範囲が
対応しているため修正不要と確認した。そのあと Lean 具体版
`distanceSquaredToRational_eq_zero_iff`、必要十分版
`distanceSquaredOfPair_eq_zero_iff_necSuf`、導出を完成させ、四層を揃えた。具体版は
一意表示の係数を `realClosedComponents` として取り出し、本文と同じく $b\ne0$ なら
$w:=(a-q)b^{-1}$ の六段で $w^2=-1$ を得る背理法を持つ。必要十分版は体上の二係数表示と
非零元の平方が $-1$ でないことだけを要求し、導出は実閉部分体のデータへ特殊化した。
入口 import と sorry 非依存検査にも登録した。式変形統一では姉妹側「トレース冪の挟み撃ち」に
残っていた $P=W$ 版 Cauchy--Schwarz の一行圧縮を五段の根拠付き連鎖へ開いた。
次の本文は「詰め寄りの述語の定式化」、次の式変形統一は同じ証明の残存圧縮の確認から続ける。

2026-08-14 の tick 246 は、レビューで前 tick の「実代数的数の順序」の Lean 三本（具体版・
必要十分版・導出）を本文と突き合わせ、修正不要と確認した。そのあとセクション
「零点と有理点の距離の二乗」を記述と SageMath まで進めた。二ブロック:
`def_distance_squared_to_rational`（写像 $\mathrm{dsq}:\overline{\mathbb{Q}}\times\mathbb{Q}\to R$。
一意表示 $\xi=a+b\cdot\omega$ と $q\in\mathbb{Q}\subseteq R$ から
$\mathrm{dsq}(\xi,q):=(a-q)\cdot(a-q)+b\cdot b\in R$。well-defined 性は一意表示・
`claim_rationals_are_real_algebraic`・部分体の閉性）と
`claim_distance_squared_zero_iff_equal`（$\mathrm{dsq}(\xi,q)=0\Leftrightarrow\xi=q$。
第 1 の向きは $q=q+0\cdot\omega$ の表示と一意性から $a=q$、$b=0$。第 2 の向きは
$b\ne0$ と仮定して $w:=(a-q)\cdot b^{-1}$ の六段の鎖で $w\cdot w=-1$ を出し、$w=0$ なら
$1\ne0$ に、$w\ne0$ なら `claim_neg_one_not_square` に矛盾。$b=0$ のあと零因子の不在で
$a=q$）。SageMath（`sagemath/check/distance-squared-to-rational/`）はモデル
$R=\texttt{AA}$、$\omega=\texttt{QQbar(I)}$ で一意表示（121 組）・所属・同値
（$\xi$ 11 点 × $q$ 6 点）を厳密検査した（成分次数 2 以下に限る理由は overview に注記）。
**Lean は未着手**で、次 tick はこの二ブロックの Lean（具体版・必要十分版・導出）を進める。
次の本文は「詰め寄りの述語の定式化」。式変形統一では姉妹側「トレース冪の挟み撃ち」の
トレース評価の $A=W^n$ への適用（三段）と、単位ベクトル上の上限を取って
$c^n\leq\mathrm{tr}(W^n)$ を得る圧縮（三段）を、それぞれ行末根拠付きの鎖へ開いた。
次の式変形統一は、同じ証明に圧縮が残っていないかを確かめてから、姉妹側の残りの証明の
未統一のものへ続ける。

2026-08-14 の tick 245 は、レビューで「実代数的数の順序」を二つの定義と一つの三分法へ分割し、
SageMath の対象ラベルも揃えて前進前に main へ反映した。そのあと同セクションの Lean 具体版・
必要十分版・導出を完成させ、四層を揃えた。有理数の所属は自然数の帰納、整数の符号、分母の
逆元と乗法を本文と同じ順で持つ。$-1$ が非零元の平方でないことは平方の三分法の第二・第三の
場合の排他性へ帰着し、狭義順序の三分法は差 $b-a$ の三分法を等号・二方向の狭義順序へ移した。
必要十分版は部分集合の閉性と三命題の排他性、差の読み替えだけを要求する。入口 import、本文対応、
sorry 非依存検査への登録も完了した。次の本文は「零点と有理点の距離の二乗」、式変形統一は
姉妹側「トレース冪の挟み撃ち」の半正定値行列のトレース評価
$x^\top Ax\leq\|x\|^2\,\mathrm{tr}(A)$ を八段の根拠付き連鎖へ開いた。次は同じ証明の直後にある、
単位ベクトル上の上限を取って $c^n\leq\mathrm{tr}(W^n)$ を得る圧縮から続ける。

2026-08-14 の tick 244 は、レビューで前 tick の「実閉部分体と虚数単位」の Lean 三本
（具体版・必要十分版・導出）を本文と突き合わせ、四条件のデータ保持と $\omega^4=1$ の三段の
対応、入口 import と sorry 非依存検査への登録が揃っているため修正不要と確認した。そのあと
セクション「零点と有理点の距離の二乗と実代数的数の順序」を「実代数的数の順序」
「零点と有理点の距離の二乗」の二片へ割り直し（順序は平方の三分法、距離の二乗は一意表示と、
使う条件と論法が別のため）、最初の一片を記述と SageMath まで進めた。五ブロック:
`claim_rationals_are_real_algebraic`（$\mathbb{Q}\subseteq R$。自然数の帰納・加法逆元・
乗法逆元と乗法の各段で部分体の閉性だけを使う）、`claim_neg_one_not_square`（零元でない
$w\in R$ で $w\cdot w\ne-1$。$z=1$ への平方の三分法の排他性からの背理法）、
`def_real_algebraic_strict_order`（$a<_R b:\Leftrightarrow\exists w\ne0,\ b-a=w\cdot w$）、
`def_real_algebraic_nonstrict_order`（$a\le_R b$）、`claim_real_algebraic_order_trichotomy`
（$z:=b-a$ への平方の三分法から従う）。順序と加法・乗法の両立、
$\mathbb{Q}$ の通常の順序との一致は本文で「まだ主張しない（必要になる箇所で示す）」と明記
した（三分法だけからは正有理数が平方であることが出ないため。導出には一意表示側の道具も要る
見込み）。SageMath（`sagemath/check/real-algebraic-order/`）はモデル $R=\texttt{AA}$ で
五ブロックを有限標本で厳密検査した（次数 2 以下に限る理由は overview に注記）。
**Lean は未着手**で、次 tick はこの五ブロックの Lean（具体版・必要十分版・導出）を進める。
式変形統一では姉妹側「トレース冪の挟み撃ち」Step 3 冒頭の比の単調性（三段）と
望遠鏡積からの下からの評価（四段）を、それぞれ一続きの根拠付きの鎖へ開いた。
次の式変形統一は同じ証明の半正定値行列のトレース評価
$x^\top Ax\le\|x\|^2\,\mathrm{tr}(A)$ の行末根拠化から続ける。
次の本文は「零点と有理点の距離の二乗」
（一意表示 $\xi=a+b\omega$ と $q\in\mathbb{Q}$ から $(a-q)^2+b^2\in R$ を定め、
零性が $\xi=q$ と同値であることを `claim_neg_one_not_square` で示す）。

2026-08-14 の tick 243 は、レビューで前 tick の「実閉部分体と虚数単位」の SageMath が
有限標本しか検査していないことを明記し、本文の $\omega^4=1$ の三段を一行一操作へ開いて
前進前に main へ反映した。そのあと Lean 具体版 `realClosedOmega_pow_four`、必要十分版
`omega_pow_four_of_square_neg_one_necSuf`、導出を完成させ、四層を揃えた。具体版は
$R\subset\overline{\mathbb{Q}}$、平方の三分法、$\omega^2=-1$、一意表示をそのまま保持する
データを定義する。必要十分版は可換環と $\omega^2=-1$ だけを要求する。式変形統一では姉妹側
「トレース冪の挟み撃ち」Step 2 の奇数・偶数の場合分けを、それぞれ四段の根拠付き不等式鎖へ
開いた。次の式変形統一は同じ証明の Step 3 冒頭にある比の単調性と積表示、次の本文は
「零点と有理点の距離の二乗と実代数的数の順序」から続ける。

2026-08-14 の tick 242 は、レビューで前 tick の「正の有理点は Fisher 零点でない」の Lean 三本
（具体版・必要十分版・導出）を本文と突き合わせ、評価の三段と背理法の対応、入口 import と
sorry 非依存検査への登録が揃っているため修正不要と確認した。そのあとセクション
「相転移を $\mathbb{Q}$ 上の量化言明として書く（詰め寄りの述語の定式化）」を
「実閉部分体と虚数単位の固定」「零点と有理点の距離の二乗と実代数的数の順序」
「詰め寄りの述語の定式化」の三片へ割り直し（距離・順序・共役の道具が本文に無いため）、
最初の一片を記述と SageMath まで進めた。定義 `def_real_closed_subfield` は
$\overline{\mathbb{Q}}$ の部分体 $R$ と元 $\omega$ の組を 4 条件（部分体・平方の三分法・
$\omega^2=-1$・一意表示 $\xi=a+b\omega$）で固定する（存在は Artin--Schreier の定理で既知と
して引く）。SageMath（`sagemath/check/real-closed-subfield/`）はモデル $R=\texttt{AA}$、
$\omega=\texttt{QQbar(I)}$ で 4 条件を厳密検査した。高次の代数的数の exactify（PARI の
nfinit）は資源上限で終わらないため、Fisher 零点そのもの（次数 8 以上）での分解検査は外し、
overview に範囲の注記として明記した（次数の低いサンプルで検査。検査内容は緩めていない）。
**Lean は未着手**で、次 tick はこのブロックの Lean（具体版・必要十分版・導出）を進める。
締切（45 分枠）のため式変形統一はこの tick では実施できなかった。次の式変形統一は姉妹側
「トレース冪の挟み撃ち」Step 2 の奇数・偶数の場合分けの圧縮から、次の本文は
「零点と有理点の距離の二乗と実代数的数の順序」から続ける。

2026-08-14 の tick 241 は、レビューで前 tick の「正の有理点は Fisher 零点でない」の本文と
SageMath を突き合わせ、代数的数での係数表示、有理数での代入値との一致、正値性、零点定義に
よる背理法が同じ順で対応しているため修正不要と確認した。そのあと同じ主張の Lean 具体版
`positiveRational_not_mem_fisherZero`、必要十分版
`embedded_nonzero_value_not_mem_zeroSet_necSuf`、導出を完成させ、四層を揃えた。
必要十分版は内側の値の非零性、埋め込み後の値との一致、零元保存、単射性、零点集合の所属と
評価値の零性の対応だけを要求する。次の本文は「相転移を $\mathbb{Q}$ 上の量化言明として書く
（詰め寄りの述語の定式化）」。式変形統一では姉妹側「トレース冪の挟み撃ち」の Step 2 にある
$P=I$ 版の圧縮を八段の根拠付き等式・不等式鎖へ開いた。次の式変形統一は直後の奇数・偶数の
場合分けの圧縮から続ける。

2026-08-14 の tick 240 は、レビューで前 tick の「双対な点どうしの $\Phi_L$ の値の関係」の
Lean 三本（具体版・必要十分版・導出）を本文と突き合わせ、双対分解の六段と自由エントロピーの
七段が calc の鎖として同じ順に対応し、登録も揃っているため修正不要と確認した。そのあと
「零点の詰め寄り」章を開き、セクション「相転移を $\mathbb{Q}$ 上の量化言明として書く」を
「正の有理点は Fisher 零点でない」と「詰め寄りの述語の定式化」の二片へ割り直し、最初の一片を
記述と SageMath まで進めた。主張（`claim_positive_rational_not_fisher_zero`）:
$L\ge1$、$q\in\mathbb{Q}_{>0}$ ならば $q\notin\mathcal{F}_L$。証明は
$\mathrm{Ev}^F_q(Z_L)=\sum_m\Omega_L(m)q^m$（`def_qbar_polynomial_evaluation` と係数表示）、
部分体 $\mathbb{Q}$ での代入値 $Z_L(q)$ との一致、正値性
`claim_value_at_rational_is_positive` の三段の鎖と、零元の部分体一致からの背理法で閉じる。
SageMath（`sagemath/check/positive-rational-not-fisher-zero/`）は $L=1,2,3$ × 正の有理点
11 個（1 未満・1・1 超え）で全段と、`QQbar` の全根に正の有理数が無いことを厳密検査した。
**Lean は未着手**で、次 tick はこのブロックの Lean（具体版・必要十分版・導出）を完成させる。
次の本文は残りの一片「相転移を $\mathbb{Q}$ 上の量化言明として書く（詰め寄りの述語の定式化）」。
式変形統一では姉妹側「トレース冪の挟み撃ち」の各標準基底の評価を $d$ 個足す散文内の圧縮を、
トレースの標準基底表示・項ごとの不等式の有限和・同じ項の $d$ 個の和・略記 $d=2^M$ を
行末根拠にした四段の一続きの鎖へ開いた。次の式変形統一は同じ証明の Step 2 の $P=I$ 版の
散文内等式 $(m_{a+b})^2\le m_{2a}m_{2b}$ から続ける。

2026-08-14 の tick 239 は、前 tick の「分配多項式の値の双対分解」の本文で積の結合則と
冪の指数法則を一つの等号へまとめ、SageMath も中間段を飛ばしていた箇所を二段へ分け、検算と
overview を同じ粒度へ揃えた。その修正を独立して push したあと、「双対な点どうしの
$\Phi_L$ の値の関係」の Lean 具体版 `partitionValueDualFactorization`・
`freeEntropyDualRelation`、必要十分版、導出を完成させ、四層を揃えた。具体版は本文と同じ
低温展開の自明セクター表示、混合双対恒等式、四つのセクター値双対、正値性、対数の加法性・
冪の法則を一段ずつ持つ。必要十分版は双対分解を可換半環、自由エントロピーの鎖を加法可換群の
等式だけへ薄めた。次の本文は「零点の詰め寄り」章の最初のセクション、次の式変形統一は
姉妹側「トレース冪の挟み撃ち」で各標準基底の評価を足す箇所。式変形統一では、その直前の
奇数冪の上からの評価にあった四式の圧縮を、冪の指数法則・実対称性・レイリー商の上限・
作用素ノルム評価・積の冪を行末根拠にした六段の一続きの鎖へ開いた。

2026-08-14 の tick 238 は、レビューで前 tick の「セクター多項式の値の双対関係」の Lean 三本
（具体版・必要十分版・導出）を本文と突き合わせ、双対の準備等式・積の冪・冪の指数法則・
括り出しの各段が対応し登録も揃っているため修正不要と確認した。そのあとセクション
「双対な点どうしの $\Phi_L$ の値の関係」を記述と SageMath まで進めた。二ブロック:
分配多項式の値の双対分解（`claim_partition_value_dual_factorization`）
$2^{L^2}Z_L(q)=(1+q)^{2L^2}\sum_{(a,b)}G^{a,b}_L(\mathrm{KW}(q))$（低温展開の自明セクター表示・
混合双対恒等式・セクター値双対の四つの同時適用・分配則の括り出しの五段の鎖）と、
双対な点どうしの自由エントロピーの関係（`claim_free_entropy_dual_relation`）
$L^2\ell_2+\Phi_L(q)=2L^2\log(1+q)+\log\bigl(\sum_{(a,b)}G^{a,b}_L(\mathrm{KW}(q))\bigr)$
（$\Lambda$ の等式。証明冒頭で略記 $S$ と正値性を準備し、四セクター和の正値性は値の双対分解
からの背理法。鎖は対数の加法性 `claim_log_additive` と冪の法則 `claim_log_power` の七段）。
SageMath（`sagemath/check/free-entropy-dual-relation/`）は $L=1,2,3$ × 有理点 6 個で両主張の
全段を厳密検査した（$\Lambda$ は素因数分解の指数ベクトルの辞書で実装）。本文末尾
「この先に書くこと」から済んだこの項目を消した。**Lean は未着手**で、次 tick はこの二ブロック
の Lean（具体版・必要十分版・導出）を完成させる。式変形統一では姉妹側
「トレース冪の挟み撃ち」の Step 1 の偶数冪の根拠なし連鎖を、冪の指数法則・実対称性・
ノルムの定義・レイリー上限評価の $a$ 回適用・積の冪を行末根拠にした五段の鎖へ開いた。
次の式変形統一は同じ証明の奇数冪の上からの評価から続ける。
次の本文は「零点の詰め寄り」章の最初のセクション。

2026-08-14 の tick 237 は、レビューで前 tick の「セクター多項式の値の双対関係」の本文と
SageMath を突き合わせ、準備の等式・項単位の三段・有限和の主張が一致するため修正不要と
確認した。そのあと Lean 具体版 `sectorValueDuality`、必要十分版
`sector_value_duality_necSuf`、導出を完成させ、四層を揃えた。具体版は整数係数多項式を
有理点で評価し、本文と同じ各項の書き換えと共通因子の括り出しを実装する。必要十分版は
可換半環、有限和、指数の上界、二つの重みだけを要求する。式変形統一では姉妹側
「トレース冪の挟み撃ち」の冒頭にあったトレースの標準基底表示を、トレースの定義と対角成分の
表示の二段へ開いた。次の本文は「双対な点どうしの $\Phi_L$ の値の関係」、次の式変形統一は
同じ証明の偶数冪の上からの評価から続ける。

2026-08-14 の tick 236 は、レビューで前 tick の「双対変換は零と一の間の有理数を保つ」の
Lean 三本（具体版・必要十分版・導出）を本文と突き合わせ、修正不要と確認した。そのあと
セクション「双対な点どうしの $\Phi_L$ の値の関係」を「セクター多項式の値の双対関係」と
「双対な点どうしの $\Phi_L$ の値の関係」の二片へ割り直し（前者は各項の書き換えと括り出し、
後者は四つの等式を混合双対恒等式で束ねる論法で、論法が別のため）、最初の一片を記述と
SageMath まで進めた。主張（`claim_sector_value_duality`）: $q\in\mathbb{Q}_{(0,1)}$、
$a,b\in\{0,1\}$ について $H^{a,b}_L(q)=(1+q)^{2L^2}\cdot G^{a,b}_L(\mathrm{KW}(q))$。
証明は、準備の等式 $(1+q)\cdot\mathrm{KW}(q)=1-q$ を $\overline{\mathbb{Q}}$ の可換則・
結合則・逆元で確かめて部分体で $\mathbb{Q}$ へ落とし、セクター多項式の各項の
$(1-q)^{|A|}=((1+q)\cdot\mathrm{KW}(q))^{|A|}$ への書き換え、積の冪の分解、冪の指数法則、
分配則による $(1+q)^{2L^2}$ の括り出しの六段の鎖で閉じる。SageMath
（`sagemath/check/sector-value-duality/`）は $L=1,2,3$ × 有理点 6 個 × 4 セクターで主張の
等式を、$L$ ごとに $q=1/2$ で項単位の中間 3 行を厳密検査して通過した。**Lean は未着手**で、
次 tick はこのブロックの Lean（具体版・必要十分版・導出）を完成させる。次の本文は残りの一片
「双対な点どうしの $\Phi_L$ の値の関係」（セクターごとの等式を四境界条件の混合の双対恒等式
`claim_mixed_boundary_duality_identity` で束ね、$\Phi_L(q)$ と双対点の量を結ぶ）。
式変形統一では姉妹側「作用素ノルムのレイリー上限評価 $\|Wx\|\le c(M)\|x\|$」
（`maxeig_007_claim_operator_bound`）の三つの根拠なし連鎖を、ノルムの定義・冪の指数法則・
Cauchy--Schwarz・二段に分けた上限評価（非負因子を明示）・可換則を行末根拠にした二つの
一続きの鎖へ開いた（姉妹側の生成器は \blkref を定義していないので、(∵…) には題を書き、
ラベル参照は式の直後に置いた）。次の式変形統一は同ファイルの次の根拠なしの計算から続ける。

2026-08-14 の tick 235 は、レビューで前 tick の「双対変換は零と一の間の有理数を保つ」の
本文と SageMath を突き合わせ、修正不要と確認した。そのあと Lean 具体版
`kwDualTransform_preservesUnitInterval`、必要十分版
`kw_dual_preserves_unit_interval_necSuf`、導出を完成させ、四層を揃えた。具体版は本文と同じ
三つの鎖と代数的数側の値との一致を持つ。必要十分版は台集合への所属、積での閉性、正値性、
正の右因子を掛けた比較、上端を与える積の等式だけを要求する。式変形統一では姉妹側
「半正定値双線型形式の Cauchy--Schwarz の不等式」の二次式展開と二つの場合分けを、
一行一演算・行末根拠の鎖へ開いた。次の本文は「双対な点どうしの $\Phi_L$ の値の関係」、
次の式変形統一は同ファイルの次の証明ブロックから続ける。

2026-08-14 の tick 234 は、レビューで前 tick の「正の根の特定」の Lean 三本を本文の
八ブロックと突き合わせ、修正不要と確認した。そのあとセクション
「一般の $q$ での $\Phi_L(q)$ の性質」を「双対変換は零と一の間の有理数を保つ」と
「双対な点どうしの $\Phi_L$ の値の関係」の二片へ割り直し（論法が別のため）、最初の一片を
記述と SageMath まで進めた。二ブロック: 集合
$\mathbb{Q}_{(0,1)}:=\{r\in\mathbb{Q}:0<r<1\}$ の定義（`def_unit_interval_rationals`。
$\mathbb{Q}_{(0,1)}\subseteq\mathbb{Q}_{>0}$ なので元での $\Phi_L$ が確定する）と、
$q\in\mathbb{Q}_{(0,1)}$ ならば $1+q\ne0$ で $\mathrm{KW}(q)$ が定義され
$\mathrm{KW}(q)\in\mathbb{Q}_{(0,1)}$ となる主張
（`claim_kw_dual_preserves_unit_interval`）。証明は $\mathbb{Q}$ の四則と順序だけで、
$t:=(1+q)^{-1}\in\mathbb{Q}$ が $\overline{\mathbb{Q}}$ の逆元と一致すること（逆元の一意性）を
経由し、$\mathrm{KW}(q)=(1-q)\cdot t\in\mathbb{Q}$、$0<(1-q)\cdot t$、
$(1-q)\cdot t<(1+q)\cdot t=1$ の三鎖で閉じた。SageMath
（`sagemath/check/kw-dual-preserves-unit-interval/`）は分母 40 までの全既約分数 489 点で
準備と三鎖の全段を厳密検査して通過した。**Lean は未着手**で、次 tick はこの二ブロックの
Lean（具体版・必要十分版・導出）を完成させる。次の本文は残りの一片
「双対な点どうしの $\Phi_L$ の値の関係」（四境界条件の混合の双対恒等式
`claim_mixed_boundary_duality_identity` を $q$ で評価して $\Phi_L(q)$ と
$\Phi_L(\mathrm{KW}(q))$ を結ぶ）。式変形統一では姉妹側「$W$ の成分はすべて正」
（`maxeig_004_claim_W_has_positive_entries`）の Step 3 にあった一行圧縮を、$W$ の定義・
行列の積の定義・対角性による二度の項の消去を行末根拠にした四段の一続きの鎖へ開いた。
次の式変形統一は同ファイルを先頭から機械走査した次の根拠なしの計算から続ける。

2026-08-14 の tick 233 は、「正の根の特定 $x_c=\sqrt2-1$」の Lean 具体版・必要十分版・導出を
完成させ、四層すべてを満たした。レビューでは前 tick の八ブロックと SageMath の二根の所属・
表示、正錐三条件、一意性を突き合わせて修正不要と確認した。具体版は本文と同じ表示の構成、
表示の一意性、有理係数の正錐判定、二根の場合分けを持つ。必要十分版は二係数表示、所属述語、
二根の排他だけを要求し、体・順序・二次体の構造を仮定しない。臨界点も `criticalPoint` として
形式化した。式変形統一では姉妹側「$W$ は実対称正定値」の $S_2$ の表示、合同変換、転置、核の
計算を一行一等号と行末根拠へ開いた。次の本文は「一般の $q$ での $\Phi_L(q)$ の性質
（双対な点どうしの関係）」、次の式変形統一は `011_max_eigenvalue.ts` の次の根拠なしの計算から続ける。

2026-08-14 の tick 232 は、レビューで前 tick の「正錐と乗法の両立」の Lean 三本を本文と
突き合わせ、修正不要と確認した。そのあと「正の根の特定 $x_c=\sqrt2-1$」を記述と SageMath
まで進めた。八ブロック: 根 $-1+s$ の所属（`claim_self_dual_root_plus_mem`）と表示 $(-1,1)$
（`claim_self_dual_root_plus_representation`）、根 $-1-s$ の所属
（`claim_self_dual_root_minus_mem`）と表示 $(-1,-1)$
（`claim_self_dual_root_minus_representation`）、$-1+s\in P_s$（第三条件 $-1<0$、$0<1$、
$1<2$。`claim_self_dual_root_plus_positive`）、$-1-s\notin P_s$（三条件すべて破れる。
`claim_self_dual_root_minus_not_positive`）、正の根の一意性
（`claim_self_dual_positive_root_unique`。自己双対方程式の根で $P_s$ に属するものは $-1+s$
に限る）、臨界点の定義 $x_c:=-1+s$（`def_critical_point`。実数の順序は使わず、$\sqrt2-1$ は
流儀の照合としてのみ言及）。SageMath（`sagemath/check/self-dual-root-positive/`）は
$s\cdot s=2$ の 2 つの $s$ の両方で全段（所属の鎖・表示・三条件の判定・一意性・自己双対方程式）
を厳密検査して通過した。本文末尾「この先に書くこと」から済んだ Fisher 零点の項目を消した。
**Lean は未着手**で、次 tick はこの八ブロックの Lean（具体版・必要十分版・導出）を完成させる。
式変形統一では姉妹側「$Z=\mathrm{tr}(W^n)$」（`011_max_eigenvalue.ts` の
`maxeig_002_claim_Z_equals_trace_of_W`）の証明にあった二つの根拠なし連鎖（$W^n$ の括り直しと
トレースの巡回性の三等号）を、結合法則・冪の定義・$V_1=BB$・巡回性・$W=BV_2B$ を行末根拠に
した七段の一続きの鎖へ開いた。次の式変形統一は同ファイルを先頭から機械走査した次の根拠なしの
計算（散文内の等号を含む）から続ける。

2026-08-14 の tick 231 は、レビューで前 tick の「正錐と乗法の両立」の本文と SageMath を
突き合わせ、積の表示、可換則による転送、九通りの符号場合の網羅が一致するため修正不要と確認した。
そのあと Lean 具体版 `quadraticPositiveCone_mul_mem`、必要十分版
`positive_cone_mul_closed_necSuf`、導出を完成させ、四層を揃えた。具体版は六つの積の補題と
逆順の積からの転送で本文どおり九通りを閉じ、必要十分版は型・二項演算・所属述語・三条件・
六補題・転送だけを仮定して順序も代数構造も要求しない。導出は具体的な正錐を必要十分版へ
特殊化した。入口 import と sorry 非依存検査へ三定理を登録した。式変形統一では姉妹側
「レイリー上限のセクター分解」末尾の $\mathcal R_\pm\subseteq\mathcal R$ から
$c_\pm\le c(M)$、$\max(c_+,c_-)\le c(M)$ を得る散文内の上限比較を、定義・上限の単調性・
直前の上界を行末根拠にした鎖へ開いた。次の本文は「正の根の特定 $x_c=\sqrt2-1$」。
次の式変形統一は `011_max_eigenvalue.ts` を先頭から機械走査した次の根拠なしの計算から続ける。

2026-08-14 の tick 230 は、レビューで前 tick の「二つの混合符号条件の積」の Lean 三本を
本文と突き合わせ、修正不要と確認した。そのあと「正錐と乗法の両立」
（`claim_quadratic_positive_cone_mul_closed`）を記述と SageMath まで進めた。
加法版「正錐と加法の両立」と同じ組み立てで、
$\mathrm{rep}_s(\xi\cdot\eta)=(a\cdot a'+2\cdot(b\cdot b'),\ a\cdot b'+b\cdot a')
=\mathrm{rep}_s(\eta\cdot\xi)$（$\mathbb{Q}$ の乗法・加法の可換則）による転送を準備し、
九通りの符号場合を既存の六つの積の補題（非負どうし、非負×負の第二、非負×負の第一、
負の第二どうし、負の第一どうし、混合符号）と転送で尽くした。SageMath
（`sagemath/check/quadratic-positive-cone-mul-closed/`）は正錐の表示の全順序対 69696 組で、
積の表示が三条件の少なくとも一つを満たすこと・転送の可換則・九通りの網羅を厳密検査して
通過した。**Lean は未着手**で、次 tick はこの主張の Lean（具体版・必要十分版・導出。
加法版 `quadraticPositiveCone_add_mem` の三本と同じ構成で、六つの積の補題を場合分けで呼ぶ）を
完成させる。式変形統一では姉妹側「レイリー上限のセクター分解」末尾のレイリー商の上界の
三段圧縮を、交叉項の消去・各セクターの上限の適用・積の単調性・分配則・ノルムの分解・
$\|x\|=1$ を行末根拠にした七段の鎖へ開いた。次の式変形統一は同ファイルの次の根拠なしの
計算（散文内の等号を含めて機械走査する）から続ける。

2026-08-14 の tick 229 は、「二つの混合符号条件の積」の Lean 具体版
`quadraticPositive_mul_of_mixedSigns`、必要十分版 `positive_mul_mixedSigns_necSuf`、導出を完成させ、
四層を揃えた。レビューでは本文と SageMath の二係数の符号、中間比較、移項、交差項の付加、
平方展開を突き合わせて修正不要と確認した。具体版は本文の鎖を有理係数二次体上で自前で実装し、
必要十分版は線形順序可換環上で同じ鎖を持ち、導出は必要十分版を特殊化する。式変形統一では
姉妹側「レイリー上限のセクター分解」の交叉項消去を五段の根拠付き等式鎖へ開いた。
次の本文は「正錐と乗法の両立の組み立て」、次の式変形統一は同じ証明のレイリー商の上界から続ける。

2026-08-14 の tick 228 は、レビューで前 tick の「負の第一係数条件どうしの積」の Lean 三本を
本文と突き合わせ、修正不要と確認した。そのあと「二つの混合符号条件の積」
（`claim_quadratic_positive_mul_mixed_signs`）を記述と SageMath まで進めた。
$\xi$ が負の第二係数条件、$\eta$ が負の第一係数条件を満たす場合で、$u:=-b$、$c':=-a'$ を
置くと積の表示は $(A,B)=(-(a\cdot c'+2\cdot(u\cdot b')),\ a\cdot b'+u\cdot c')$ で、
正どうしの積の和から $A<0$（$C:=a\cdot c'+2\cdot(u\cdot b')>0$、$A=-C$）と $0<B$ を得る。
$D:=a\cdot a-2\cdot(u\cdot u)>0$ を使う中間比較 $D\cdot(c'\cdot c')<D\cdot(2\cdot(b'\cdot b'))$
を移項し、交差項 $4\cdot((a\cdot c')\cdot(u\cdot b'))$ を両辺へ加えて
$A\cdot A<2\cdot(B\cdot B)$（負の第一係数条件）へつないだ。場合分けは不要。
逆順（負の第一 × 負の第二）は「正錐と乗法の両立の組み立て」で積の可換則による転送で
帰着する予定。SageMath（`sagemath/check/quadratic-positive-mul-mixed-signs/`）は 67308 組で
各段を厳密検査して通過した。**Lean は未着手**で、次 tick はこの主張の Lean
（具体版・必要十分版・導出）を完成させる。式変形統一では姉妹側
「レイリー上限のセクター分解」(3) の直交性 $x_+^\top x_-=0$ の三等号の圧縮を、
転置の積の法則・射影子の実対称性・$P^{(+)}P^{(-)}=0$・零行列の作用を行末根拠にした
五段の鎖へ開いた。次の式変形統一は同じ証明の直後にある交叉項消去の計算
（$x^\top Wx=x_+^\top Wx_++x_-^\top Wx_-$）から続ける。

2026-08-14 の tick 227 は、「負の第一係数条件どうしの積」の Lean 具体版
`quadraticPositive_mul_of_negativeFirst_negativeFirst`、必要十分版
`positive_mul_negativeFirst_negativeFirst_necSuf`、導出を完成させ、四層を揃えた。
レビューでは本文と SageMath を突き合わせ、移項後の不等式に欠けていた行末根拠を補って
前進前に反映した。具体版は本文と同じ正因子による中間比較・移項・交差項の付加・平方展開を
有理係数二次体上で自前で実装し、必要十分版は線形順序可換環上で同じ鎖を持つ。
式変形統一では姉妹側「レイリー上限のセクター分解」の $WP^{(\pm)}$ から
$V^{(\pm)}P^{(\pm)}$ までを、射影子の可換性・冪等性と半冪の制限等式を明示した
五段の根拠付き等式鎖へ開いた。次の本文は「二つの混合符号条件の積」、次の式変形統一は
同ファイルの次の根拠なしの計算から続ける。

2026-08-14 の tick 226 は、レビューで前 tick の「負の第二係数条件どうしの積」の Lean 三本を
本文と突き合わせ、修正不要と確認した。そのあと「負の第一係数条件どうしの積」
（`claim_quadratic_positive_mul_negative_first_negative_first`）を記述と SageMath まで進めた。
$c:=-a$、$c':=-a'$ を置くと積の表示は
$(A,B)=(c\cdot c'+2\cdot(b\cdot b'),\ -(c\cdot b'+b\cdot c'))$ で、正どうしの積の和から
$0<A$、$0<V:=c\cdot b'+b\cdot c'$ により $B<0$ を得る。$D:=2\cdot(b\cdot b)-c\cdot c>0$
を使う中間比較 $D\cdot(c'\cdot c')<D\cdot(2\cdot(b'\cdot b'))$ を移項し、交差項
$4\cdot((c\cdot c')\cdot(b\cdot b'))$ を両辺へ加えて $2\cdot(B\cdot B)<A\cdot A$
（負の第二係数条件）へつないだ。前 tick「負の第二係数条件どうしの積」の鏡像
（$a,b$ の役割交換）で場合分けは不要。SageMath
（`sagemath/check/quadratic-positive-mul-negative-first-negative-first/`）は 99856 組で
各段を厳密検査して通過した。**Lean は未着手**で、次 tick はこの主張の Lean
（具体版・必要十分版・導出）を完成させる。式変形統一では姉妹側
「レイリー上限のセクター分解」（`011_max_eigenvalue`）の
$\varepsilon(Wf)=W(\varepsilon f)=W(\pm f)=\pm Wf$ の一行圧縮を、結合則・可換の等式鎖・
固有空間の定義・スカラー倍の交換を行末根拠にした五段の等式鎖へ開いた。
次の式変形統一は同ファイルの次の根拠なしの計算（散文内の等号を含めて機械走査する）から続ける。

2026-08-14 の tick 225 は、「負の第二係数条件どうしの積」の Lean 具体版
`quadraticPositive_mul_of_negativeSecond_negativeSecond`、必要十分版
`positive_mul_negativeSecond_negativeSecond_necSuf`、導出を完成させ、四層を揃えた。レビューでは
前 tick の本文と SageMath の係数の符号、中間比較、移項、交差項の付加、平方展開を突き合わせて
修正不要と確認した。具体版は本文の鎖を有理係数二次体上で自前で実装し、必要十分版は線形順序
可換環上で同じ鎖を持ち、導出は必要十分版を特殊化する。入口 import と sorry 非依存検査にも
三定理を登録した。式変形統一では姉妹側「レイリー上限のセクター分解」の
$\varepsilon W=W\varepsilon$ を、$W$ の定義と可換性を行末根拠にした五段の等式鎖へ開いた。
次の本文は「負の第一係数条件どうしの積」、次の式変形統一は同じ証明の直後にある
$\varepsilon(Wf)=W(\varepsilon f)=W(\pm f)=\pm Wf$ の計算から続ける。

2026-08-14 の tick 224 は、レビューで前 tick の「非負係数条件と負の第一係数条件の積」の
Lean 三本を本文と突き合わせ、修正不要と確認した。そのあと「負の第二係数条件どうしの積」
（`claim_quadratic_positive_mul_negative_second_negative_second`）を記述と SageMath まで
進めた。$u:=-b$、$u':=-b'$ を置くと積の表示は
$(A,B)=(a\cdot a'+2\cdot(u\cdot u'),\ -(a\cdot u'+u\cdot a'))$ で、正どうしの積の和から
$0<A$、$0<V:=a\cdot u'+u\cdot a'$ により $B<0$ を得る。$D:=a\cdot a-2\cdot(u\cdot u)>0$
を使う中間比較 $D\cdot(2\cdot(u'\cdot u'))<D\cdot(a'\cdot a')$ を移項し、交差項
$4\cdot((a\cdot a')\cdot(u\cdot u'))$ を両辺へ加えて $2\cdot(B\cdot B)<A\cdot A$
（負の第二係数条件）へつないだ。場合分けは不要（先行二つの積の補題と違い、両係数の
符号が確定する）。SageMath
（`sagemath/check/quadratic-positive-mul-negative-second-negative-second/`）は 45369 組で
各段を厳密検査して通過した。**Lean は未着手**で、次 tick はこの主張の Lean
（具体版・必要十分版・導出）を完成させる。式変形統一では姉妹側
「$\varepsilon$ は $V_1,V_2,V_1^{(\pm)}$ と可換」（`010_transfer_matrix_bridge`）の散文に
埋まっていた二つの計算（Step 2 末尾のスカラー因子の付加による
$\varepsilon V_2=V_2\varepsilon$ の導出と、Step 5 の線型結合との可換）を、
一行一等号と行末根拠の鎖へ開いた。次の式変形統一は同ファイルの次の根拠なしの計算
（散文内の等号を含めて機械走査する）から続ける。

2026-08-14 の tick 223 は、「非負係数条件と負の第一係数条件の積」
（`claim_quadratic_positive_mul_nonnegative_negative_first`）の Lean 具体版・必要十分版・導出を
完成させ、四層すべてを満たした。レビューでは本文と SageMath の混合符号の排除、二つの背理法、
二つの線形比較、二つの平方比較の各段を突き合わせ、修正不要と確認した。具体版
`quadraticPositive_mul_of_nonnegative_negativeFirst` は本文と同じ鎖を自前で持ち、必要十分版
`positive_mul_nonnegative_negativeFirst_necSuf` は二次体を外して線形順序可換環上で同じ手順を実装し、
導出は必要十分版を有理係数の二次体へ特殊化する。入口 import と sorry 非依存検査へ三定理を登録し、
SageMath は 181700 組、構造化テキスト・PDF・Lean の全検証も通過した。式変形統一では姉妹側
「$2\times2$ の転送行列の恒等式」Step 1 の $(\sigma^x)^{2p}=I$ と
$(\sigma^x)^{2p+1}=\sigma^x$ を、冪の指数法則・$(\sigma^x)^2=I$・単位行列の作用を明示した
根拠付き等式鎖へ開いた。次の本文は「負の第二係数条件どうしの積」、次の式変形統一は
同ファイルの次の根拠なしの計算（散文内の等号も対象に機械走査する）から続ける。

2026-08-14 の tick 222 は、レビューで前 tick の「非負係数条件と負の第二係数条件の積」の
Lean の流儀の逸脱を直した（具体版が必要十分版を呼ぶだけの包装、導出が具体版を呼ぶだけの
空洞になっていたのを、具体版へ本文と 1 対 1 の証明を書き、導出へ必要十分版経由の証明を
移した）。そのあと「非負係数条件と負の第一係数条件の積」
（`claim_quadratic_positive_mul_nonnegative_negative_first`）を記述と SageMath まで進めた。
$c:=-a'$ を置き、積の表示 $(A,B)=(2\cdot(b\cdot b')-a\cdot c,\ a\cdot b'-b\cdot c)$ について、
混合符号の排除で二場合に分けた。$2(b\cdot b)<a\cdot a$ の場合は背理法
（$B\le0$ なら $(a\cdot a)\cdot(b'\cdot b')\le(b\cdot b)\cdot(c\cdot c)<(b\cdot b)\cdot2(b'\cdot b')$
から $a\cdot a<2(b\cdot b)$ が出て矛盾）で $0<B$ を得て、$0\le A$ なら第一条件、$A<0$ なら
$C:=-A$ と線形比較 $b'\cdot C\le c\cdot B$ を平方へ移して $A\cdot A<2(B\cdot B)$（第三条件）を
得る。$a\cdot a<2(b\cdot b)$ の場合は対称に $0<A$ で、$0\le B$ なら第一条件、$B<0$ なら
$V:=-B$ と $(2\cdot b')\cdot V\le c\cdot A$ から $2(B\cdot B)<A\cdot A$（第二条件）を得る。
SageMath（`sagemath/check/quadratic-positive-mul-nonnegative-negative-first/`）は 181700 組で
各段を厳密検査して通過した。**Lean は未着手**で、次 tick はこの主張の Lean
（具体版・必要十分版・導出）を完成させる。式変形統一では姉妹側
「$2\times2$ の転送行列の恒等式」（`010_transfer_matrix_bridge`）Step 2 の散文に
根拠なしで埋まっていた $e^{-K_2^*}=t^{1/2}$、$e^{K_2^*}=t^{-1/2}$ を、
指数法則と正の平方根・逆数の根拠付き等式鎖へ開いた。次の式変形統一は同ファイルの
次の根拠なしの計算（散文内の等号を含めて機械走査する）から続ける。

2026-08-14 の tick 221 は、「非負係数条件と負の第二係数条件の積」の Lean 具体版・
必要十分版・導出を完成させ、四層すべてを満たした。本文と SageMath のレビューでは、
二つの背理法、二つの線形比較、二つの平方比較の各中間段と四つの符号場合が一致しており、
修正不要と確認した。必要十分版は二次体を外し、線形順序可換環上で同じ論法を実装した。
入口 import と sorry 非依存検査へ三定理を登録した。式変形統一では姉妹側
「サイト演算子の基底作用」に分断されていた七段を、一続きの根拠付き等式鎖へ統合した。
次の本文は「非負係数条件と負の第一係数条件の積」、次の式変形統一は姉妹側
`010_transfer_matrix_bridge` の次の根拠なしの計算から続ける。

2026-08-14 の tick 220 は、「非負係数条件と負の第二係数条件の積」
（`claim_quadratic_positive_mul_nonnegative_negative_second`）を記述と SageMath まで進めた。
$u:=-b'$ を置き、積の表示 $(A,B)=(a\cdot a'-2(b\cdot u),\ b\cdot a'-a\cdot u)$ について、
混合符号の排除（`claim_rational_square_ne_double_square`）で $a\cdot a\ne2(b\cdot b)$ を
確かめてから二場合に分けた。$2(b\cdot b)<a\cdot a$ の場合は、$A\le0$ と仮定すると平方比較の
鎖から $a\cdot a<2(b\cdot b)$ が出て矛盾するので $0<A$ であり、$0\le B$ なら第一条件、
$B<0$ なら $V:=-B$ と線形比較 $a'\cdot V\le u\cdot A$ を平方へ移して
$2(B\cdot B)<A\cdot A$（第二条件）を得る。$a\cdot a<2(b\cdot b)$ の場合は対称に $0<B$ で、
$0\le A$ なら第一条件、$A<0$ なら $C:=-A$ と $a'\cdot C\le(2u)\cdot B$ から
$A\cdot A<2(B\cdot B)$（第三条件）を得る。SageMath
（`sagemath/check/quadratic-positive-mul-nonnegative-negative-second/`）は 122475 組で
背理法の鎖・線形比較・平方の鎖の各段を厳密検査して通過した。**Lean は未着手**で、
次 tick はこの主張の Lean（具体版・必要十分版・導出）を完成させる。レビューでは前 tick の
「正錐の非負係数条件どうしの積」を四層で突き合わせ、修正不要と確認した。式変形統一では
姉妹側「$2\times2$ の転送行列の恒等式」（`010_transfer_matrix_bridge`）Step 3 の散文に
埋まっていた $2s_2=4\sinh K_2\cosh K_2$ の導出を、$s_2$ の代入・倍角公式・数の積の結合則の
三段の根拠付き等式鎖へ開いた（姉妹側の生成器は `\blkref` を定義しないので、ラベル参照は
鎖の直後の散文に置いた。既存の流儀どおり）。次の式変形統一は同ファイルの次の根拠なしの
計算（機械走査で特定する。散文内の等号も対象に見る）から続ける。

2026-08-14 の tick 219 は、「正錐と乗法の両立」を独立な六つの符号場合と最後の
組み立てへ割り、先頭の「正錐の非負係数条件どうしの積」を四層すべてで完成させた。
積の表示 $(A,B)=(aa'+2bb',ab'+ba')$ は非負係数から $A,B\ge0$ となる。さらに各因子は
非零なのでそれぞれ少なくとも一方の係数が正であり、正係数の四通りに応じて
$aa'>0$、$ab'>0$、$ba'>0$、$2bb'>0$ のいずれかから $A>0$ または $B>0$ を得る。
SageMath（`sagemath/check/quadratic-positive-mul-nonnegative/`）は 330625 組で表示の
非負・非零と四場合を厳密検査した。Lean は本文と同じ四場合の具体版、二座標の非負性と
四場合の正値転送だけを要求する必要十分版、および導出を備える。レビューでは前 tick の
「正錐と加法の両立の組み立て」を四層で突き合わせ、修正不要と確認した。式変形統一では
姉妹側「分配関数の偶奇セクター分解」の結論部に残っていた射影子の代入と四項展開を、
二段の根拠付き等式鎖へ直した。次の本文は「非負係数条件と負の第二係数条件の積」、
次の式変形統一は機械走査で特定する次の根拠なしの計算から続ける。

2026-08-14 の tick 218 は、「正錐と加法の両立の組み立て」を四層すべてで完成させた。
正錐の定義から二元 $\xi,\eta\in P_s$ の表示がそれぞれ三条件（非負係数・負の第二係数・
負の第一係数）のいずれかを満たすことを取り、九通りの組み合わせを六つの符号場合の補題で
尽くした。補題が直接当たらない三つの順序対は、表示の各成分の加法の可換則
$\mathrm{rep}_s(\xi+\eta)=(a+a',b+b')=(a'+a,b'+b)=\mathrm{rep}_s(\eta+\xi)$ による
転送（役割の入れ替え）で帰着した。SageMath（`sagemath/check/quadratic-positive-cone-add-closed/`）は
正錐の表示の組 69696 組で和の正値・転送の可換則・九通りの網羅を厳密検査した。
Lean は同じ九場合の具体版 `quadraticPositiveCone_add_mem`、要素の型・加法・所属述語・
三条件述語・六補題・転送だけを仮定し順序も環構造も要求しない必要十分版、および導出を備える。
レビューでは前 tick の「二つの混合符号条件の和」について、本文が三段の鎖で持つ比の比較二つを
Lean が `nlinarith` 一段へ畳み SageMath も両端しか検査していなかったのを、本文と同じ三段へ
開いて前進前に反映した。式変形統一では姉妹側「分配関数の偶奇セクター分解」Step 3 の
トレースの鎖の先頭へ欠けていた行末根拠（直前の鎖の表示の代入）を付けた。
次の本文は「正錐と乗法の両立」（積の表示 `claim_quadratic_multiplication_representation` の
係数 $(aa'+2bb',\ ab'+ba')$ について同様の符号場合を扱う。論法の数で割ってから着手する）、
次の式変形統一は姉妹側 `010_transfer_matrix_bridge` の次の根拠なしの鎖
（機械走査で特定する。aligned の走査の残りは cases・pmatrix の誤検知なので散文内の等号も見る）
から続ける。

2026-08-14 の tick 217 は、「二つの混合符号条件の和」を四層すべてで完成させた。
負の第二係数条件 $(a>0,b<0,2b^2<a^2)$ と負の第一係数条件
$(a'<0,b'>0,a'^2<2b'^2)$ に対し、$c=-a'$、$u=-b$ を置いた。二条件を掛けた
平方比較から $cu<ab'$ を取り出し、和の表示 $(A,B)=(a-c,b'-u)$ の符号で分けた。
両係数が非負なら第一条件、$A\ge0>B$ なら $U=u-b'$ と $aU<uA$ を使って第二条件、
$A<0$ なら $B>0$ を示し $C=c-a$ と $b'C<cB$ を使って第三条件を得る。
SageMath は 67308 組を厳密検査し、Lean は同じ交差積比較と三場合を持つ具体版、
線形順序可換環まで薄めた必要十分版、導出を備える。式変形統一では姉妹側
「$V_1$ の成分定義とパウリ表示の一致」の指数行列の成分から転送行列の成分へ至る
場合分けを三段の一続きの鎖へ開いた。レビューでは前 tick の
「負の第一係数条件どうしの和」と姉妹側「対角行列の指数関数」を四層で突き合わせ、
修正不要と確認した。次の本文は「正錐と加法の両立の組み立て」、次の式変形統一は
姉妹側同ファイルの次の根拠なしの鎖（機械走査で特定する）から続ける。

2026-08-14 の tick 216 は、「負の第一係数条件どうしの和」を四層すべてで完成させた。
直前 tick の係数交換版で、二つの条件 $a^2<2b^2$、$a'^2<2b'^2$ を掛けて
$(aa')^2<\bigl(2bb'\bigr)^2$ を得て、非負有理数の平方の大小から $aa'<2bb'$ を
取り出し、平方展開へ組み込んで $(a+a')^2<2(b+b')^2$ を示した。SageMath は
99856 組を厳密検査し、Lean は本文と同じ積の平方比較・平方から大小を取り出す背理法・
三段の加法単調性を持つ具体版、線形順序可換環まで薄めた必要十分版、および導出を備える。
レビューでは前 tick の「負の第二係数条件どうしの和」の SageMath に和の平方展開の
中間段（狭義不等式三つと両端の等号）を追加した。式変形統一では姉妹側
「対角行列の指数関数」（`010_transfer_matrix_bridge`）の証明の散文に埋まっていた計算
（積の成分の場合分け・部分和の成分・成分ごとの収束の評価）を一行一等号と行末根拠の
鎖へ開いた。次の本文は「二つの混合符号条件の和」（正錐の第二条件と第三条件。
和の係数の符号で場合分けする）、次の式変形統一は姉妹側 `010_transfer_matrix_bridge` の
次の根拠なしの鎖（機械走査で特定する。aligned の走査では残っていないので、
散文内の等号や `\qquad` 並記の式も対象に見る）から続ける。

2026-08-14 の tick 215 は、「負の第二係数条件どうしの和」を四層すべてで完成させた。
二つの条件 $2b^2<a^2$、$2b'^2<a'^2$ を掛けて
$\bigl(2bb'\bigr)^2<(aa')^2$ を得て、非負有理数の平方の大小から
$2bb'<aa'$ を取り出し、平方展開へ組み込んで $2(b+b')^2<(a+a')^2$ を示した。
SageMath は 45369 組を厳密検査し、Lean は本文と同じ積の平方比較・平方から大小を
取り出す背理法・三段の加法単調性を持つ具体版、線形順序可換環まで薄めた必要十分版、
および導出を備える。レビューでは前 tick の「非負係数条件と負の第一係数条件の和」を
四層で突き合わせ、修正不要と確認した。式変形統一では姉妹側「セクター上での $V_1$ の
置き換え」の作用素等式を、任意のベクトルへの作用を追う一続きの鎖と行末根拠へ開いた。
次の本文は「負の第一係数条件どうしの和」、次の式変形統一は姉妹側
`010_transfer_matrix_bridge` の次の根拠なしの鎖（機械走査で特定する）から続ける。

2026-08-14 の tick 214 は、「非負係数条件と負の第一係数条件の和」を四層すべてで
完成させた。直前 tick の論法の係数交換版で、和の第一係数 $A=a+a'$ が非負なら
$0<b+b'$ から正錐の第一条件を得る。$A<0$ なら $a'\le A<0$ と $0<b'\le b+b'$ を
平方の単調性へ移し、$(a+a')^2\le a'^2<2\cdot(b'\cdot b')\le2\cdot(b+b')^2$ から
正錐の第三条件を得る。SageMath は 181700 組を厳密検査し、Lean は本文と同じ場合分けを
持つ具体版、線形順序環だけを要求する必要十分版、および導出を備える。レビューでは
前 tick の「非負係数条件と負の第二係数条件の和」の SageMath に平方比較の中間段
（$B\cdot B\le b'\cdot B$、$b'\cdot B\le b'\cdot b'$）を追加した。式変形統一では
姉妹側「$\varepsilon$ は $V_1,V_2,V_1^{(\pm)}$ と可換」の散文に埋まっていた三つの等式
（$\varepsilon R=R\varepsilon$、$\varepsilon D=D\varepsilon$、
$\varepsilon H_1^{(\pm)}=H_1^{(\pm)}\varepsilon$）を一行一等号と行末根拠の鎖へ開き、
同ブロックを完了した。次の本文は「負の第二係数条件どうしの和」（積の平方比較と
「非負有理数の平方の大小から大小」を使う）、次の式変形統一は姉妹側
`010_transfer_matrix_bridge` の次の根拠なしの鎖（機械走査で特定する）から続ける。

2026-08-14 の tick 213 は、「非負係数条件と負の第二係数条件の和」を四層すべてで
完成させた。和の第二係数 $B=b+b'$ が非負なら $0<a+a'$ から正錐の第一条件を得る。
$B<0$ なら $b'\le B<0$ と $0<a'\le a+a'$ を平方の単調性へ移し、
$2B^2\le2b'^2<a'^2\le(a+a')^2$ から正錐の第二条件を得る。SageMath は 122475 組を
厳密検査し、Lean は本文と同じ場合分けを持つ具体版、証明に必要な順序環だけを要求する
必要十分版、および導出を備える。レビューでは前 tick の「正錐の非負係数条件どうしの和」で
零和から各項の零を得る段を一ステップ一定理へ修正し、前進前に反映した。式変形統一では
姉妹側「$P^{(\pm)}$ の性質」の各計算直後へ、行末根拠に対応するラベル参照を補った。
次の本文は「非負係数条件と負の第一係数条件の和」、次の式変形統一は
「$\varepsilon$ は $V_1,V_2,V_1^{(\pm)}$ と可換」から続ける。

2026-08-14 の tick 213 のレビューでは、前 tick の「正錐の非負係数条件どうしの和」で、
非負な二項の和が零なら各項が零となる段を、零以下を導く加法操作と反対称性へ分けた。
本文・SageMath・Lean 具体版を同じ二段へ揃え、主張と必要十分版は変えていない。

2026-08-14 の tick 212 は、「正錐と加法の両立」を符号条件ごとの六つの補題と最後の
組み立てへ割り、先頭の「正錐の非負係数条件どうしの和」を四層すべてで完成させた。
表示の和 $(a+a',b+b')$ の二係数の非負性と、非負な二項の和が零なら各項が零であることから
正錐の第一条件を得る。SageMath は 3744225 組を厳密検査し、Lean は具体版・必要十分版・
導出を本文と同じ手順で持つ。レビューでは前 tick の「非負有理数の平方の大小から大小」と
姉妹側「$V_2$ の成分定義とパウリ表示の一致」を四層で突き合わせ、修正不要と確認した。
式変形統一では姉妹側「分配関数をパウリ行列表示の転送行列で書く」を、成分表示と
パウリ表示を別記号に分けた三段の鎖へ直した。次の本文は
「非負係数条件と負の第二係数条件の和」、次の式変形統一は「$P^{(\pm)}$ の性質」から続ける。

2026-08-13 の tick 211 は、「非負有理数の平方の大小から大小」の Lean 具体版・
必要十分版・導出を完成させ、四層すべてを満たした。具体版は本文と同じ背理法で、
$q\le p$ の両辺へ非負の $q$、$p$ を掛ける二段と推移律から
$q\cdot q\le p\cdot p$ を得て、仮定との連結で非反射性に矛盾させる。必要十分版は
この二段の乗法単調性、二つの推移、非反射性、$\neg(q\le p)$ から $p<q$ へ戻す規則だけを
個別に要求し、型へ順序構造も乗法構造も要求しない。レビューでは前 tick の本文・
SageMath と姉妹側「$2\times2$ の転送行列の恒等式」の式変形統一を突き合わせ、修正不要と
確認した。式変形統一では姉妹側「$V_2$ の成分定義とパウリ表示の一致」の証明を、
一行一等号と行末根拠へ開いた。次の本文は「正錐と加法の両立」、次の式変形統一は
「分配関数をパウリ行列表示の転送行列で書く」から続ける。

2026-08-13 の tick 210 は、todo 先頭の「正錐と加法の両立」から、台帳の備考どおり補題
「非負有理数の平方の大小から大小」（`claim_rational_square_lt_implies_lt`。任意の
$p,q\in\mathbb{Q}$ について $0\le p$ かつ $0\le q$ かつ $p\cdot p<q\cdot q$ ならば
$p<q$）を独立の論法（背理法 1 本）として先へ割り出し、記述と SageMath まで進めた。
証明は背理法で、$q\le p$ の両辺へ非負の $q$、$p$ を掛ける二段と推移律で
$q\cdot q\le p\cdot p$ を得て、仮定 $p\cdot p<q\cdot q$ との連結で非反射性と矛盾させ、
全順序で $p<q$ へ戻す。この補題は「正錐と加法の両立」の第二・第三条件どうしの和で、
二つの平方の大小（$(2\cdot(b\cdot b'))^2<(a\cdot a')^2$ の形）から積そのものの大小
（$2\cdot(b\cdot b')<a\cdot a'$）を取り出す根拠になる。SageMath
（`sagemath/check/rational-square-lt-implies-lt/`）は非負有理数の組で主張 10296 組・
背理法の鎖 10440 組・全順序の同値 20736 組を厳密検査して通過した。**Lean は未着手**で、
次 tick はこの主張の Lean（具体版・必要十分版・導出）を完成させる。レビューでは前 tick の
「二次体の積の表示」の Lean 三本と姉妹側「$2\times2$ の転送行列の恒等式」の式変形統一を
突き合わせ、修正不要と確認した。式変形統一では姉妹側「$2\times2$ の転送行列の恒等式」に
残っていた根拠なしの表示式三つ（Step 1 の成分表示、Step 2 冒頭の
$e^{-2K_2^*}=\tanh K_2$、Step 3 の平方根の二式）を一行一等号と行末根拠へ開き、
$t:=\tanh K_2$ の定義を等式の鎖から分離して、同ブロックの統一を完了した。次の統一は
同ファイルの次の根拠なしの鎖から続ける。

2026-08-13 の tick 209 は、「二次体の積の表示」の Lean 具体版・必要十分版・
導出を完成させ、四層すべてを満たした。具体版は本文と同じ三つの補助等式と
十四段の等式列で積の表示を作り、表示の一意性を適用する。必要十分版が
要求するのは、表示を作る等式と表示写像の一意性だけである。レビュでは前 tick の
本文・SageMath・姉妹側の式変形統一を突き合わせ、修正不要と確認した。式変形統一では
姉妹側「$2\times2$ の転送行列の恒等式」の指数行列の偶数項・奇数項分解と双曲線関数への
書き換えを、一行一等号と行末根拠の二行へ開いた。次の本文は「正錐と加法の両立」、
式変形統一は同証明の次の鎖から続ける。

2026-08-13 の tick 208 は、todo 先頭の「二次体の積の表示」
（`claim_quadratic_multiplication_mem`・`claim_quadratic_multiplication_representation`。
$\xi,\eta\in Q_s$ について $\xi\cdot\eta\in Q_s$ と
$\mathrm{rep}_s(\xi\cdot\eta)=(a\cdot a'+2\cdot(b\cdot b'),\ a\cdot b'+b\cdot a')$）を記述と
SageMath まで進めた。証明は三つの補助等式（$a\cdot(b'\cdot s)=(a\cdot b')\cdot s$ が 1 段、
$(b\cdot s)\cdot a'=(b\cdot a')\cdot s$ が 3 段、
$(b\cdot s)\cdot(b'\cdot s)=2\cdot(b\cdot b')$ が $s\cdot s=2$ を使う 7 段）を準備に置き、
十四段の鎖で $\xi\cdot\eta=(a\cdot a'+2\cdot(b\cdot b'))+(a\cdot b'+b\cdot a')\cdot s$ を
立てる。閉性は証人 $(a\cdot a'+2\cdot(b\cdot b'),\ a\cdot b'+b\cdot a')$、表示は一意性
（`claim_quadratic_representation_unique`）の適用で得る。SageMath
（`sagemath/check/quadratic-multiplication/`）は $t^2-2$ の両根 × 有理数四つ組（7 値）で
両立 49 組・補助等式と鎖と表示 4802 組を厳密検査して通過した。**Lean は未着手**で、次 tick は
この二主張の Lean（具体版・必要十分版・導出）を完成させる。レビューでは前 tick の
「二次体の和の表示」の Lean 三本と姉妹側「分配関数の偶奇セクター分解」の式変形統一を
突き合わせ、数学内容の修正は不要と確認した。台帳の整理では、前 tick が tick 202 の三記録を
保管庫へ移さず削除していたのを git の履歴から復元し、「これより古い N 件」を保管庫の実数に
合わせた。式変形統一では姉妹側「$V_1$ の二つの定義の一致」の証明 Step 1 にあった
$D\,f_{\iota(\mu)}$ の二等号の鎖を、定義の代入・和とベクトル積の分配・対角作用の全項への
同時適用・スカラー倍の括り出しの四行（一行一等号・行末根拠）へ開いた。次の統一は
同ファイルの次の根拠なしの鎖から続ける。

2026-08-13 の tick 207 は、「二次体の和の表示」の Lean 具体版・必要十分版・導出を
完成させ、四層すべてを満たした。具体版は本文の七段の等式列で和の表示を作り、
必要十分版は表示等式と表示の一意性だけを要求する。レビューでは前 tick の本文・
SageMath と姉妹側の式変形統一を突き合わせ、修正不要と確認した。式変形統一では姉妹側
「分配関数の偶奇セクター分解」の証明ブロックを一続きの鎖と行末根拠へ統一した。次の本文は
「二次体の積の表示」、式変形統一は姉妹側 `010_transfer_matrix_bridge` の次の鎖から続ける。

2026-08-13 の tick 206 は、todo 先頭の「正錐と加法・乗法の両立」を論法の数で四つ
（二次体の和の表示・二次体の積の表示・正錐と加法の両立・正錐と乗法の両立）へ割り、先頭の
「二次体の和の表示」（`claim_quadratic_addition_mem`・
`claim_quadratic_addition_representation`。$\xi,\eta\in Q_s$ について $\xi+\eta\in Q_s$ と
$\mathrm{rep}_s(\xi+\eta)=(a+a',b+b')$）を記述と SageMath まで進めた。証明は加法逆元の表示と
同型で、結合則・可換則・分配則の七段の鎖で $\xi+\eta=(a+a')+(b+b')\cdot s$ を立て、閉性は
証人 $(a+a',b+b')$、表示は一意性（`claim_quadratic_representation_unique`）の適用で得る。
SageMath（`sagemath/check/quadratic-addition/`）は $t^2-2$ の両根 × 有理数四つ組（7 値）で
和の両立 49 組・鎖と表示 4802 組を厳密検査して通過した。**Lean は未着手**で、次 tick は
この二主張の Lean（具体版・必要十分版・導出）を完成させる。レビューでは前 tick の
「二次体の三分律（高々一つ）」の Lean 三本と姉妹側「$\varepsilon$ は $V_1,V_2,V_1^{(\pm)}$ と
可換」の式変形統一を突き合わせ、修正不要と確認した。式変形統一では姉妹側
「$(V_1V_2)^{n}P^{(\pm)}=(V_1^{(\pm)}V_2)^{n}P^{(\pm)}$」の帰納段の鎖について、根拠の
無かった冪の定義の二行へ行末根拠を付け、複数操作をまとめていた一行（$P$ の右への移動と
冪等での吸収）を三行へ開き、行番号で指す説明段落を鎖の行末根拠へ吸収した。次の統一は
同ファイル `010_transfer_matrix_bridge` の次の根拠なしの鎖から続ける。

2026-08-13 の tick 205 は、「二次体の三分律（高々一つ）」の Lean 具体版・必要十分版・導出を
完成させ、四層すべてを満たした。具体版は零表示との二つの排他と、正錐の三条件と加法逆元側の
三条件の九つの組み合わせを本文と同じ順で退ける。必要十分版は二次体・代数的数・表示写像を
外し、順序環上の係数条件だけで同じ九場合を通す。レビューでは前 tick の本文・SageMath と
姉妹側「射影の代数」の和・像の特徴づけを突き合わせ、修正不要と確認した。式変形統一では
姉妹側「$\varepsilon$ は $V_1,V_2,V_1^{(\pm)}$ と可換」の証明に残っていたサイト演算子、
指数関数、二つの反可換性による符号相殺の鎖を、一行一等号と行末根拠へ開いた。次の本文は
「正錐と加法・乗法の両立」、式変形統一は同ファイルの次の証明から続ける。

2026-08-13 の tick 204 は、「二次体の三分律（高々一つ）」
（`claim_quadratic_trichotomy_at_most_one`。$s\cdot s=2$ を満たす
$s\in\overline{\mathbb{Q}}$ と任意の $\xi\in Q_s$ について、$\xi\in P_s$・$\xi=0$・
$-\xi\in P_s$ のうち同時に成り立つものは高々一つ）を記述と SageMath まで進めた。証明は
三通りの二つ組の排他である。零の表示 $(0,0)$ が正錐の三条件のどれも満たさないことを準備に
置いて「正と零」「零と加法逆元が正」を退け、「$\xi\in P_s$ と $-\xi\in P_s$」は
$(-a,-b)$ の三条件を $(a,b)$ の言葉へ書き直した九つの組み合わせをすべて順序の反対称性・
三分律・推移律で矛盾させる。SageMath
（`sagemath/check/quadratic-trichotomy-at-most-one/`）は $t^2-2$ の両根 × 有理数標本で、
高々一つの判定 1458 組・零表示が三条件を満たさないこと 3 件・書き直しの同値 729 組・
九つの組み合わせの排他 6561 組を厳密検査して通過した。**Lean は未着手**で、次 tick は
この主張の Lean（具体版・必要十分版・導出）を完成させる。レビューでは前 tick の
「二次体の三分律（少なくとも一つ）」の Lean 三本と姉妹側「射影の代数」の冪等性・直交性の
式変形統一を突き合わせ、修正不要と確認した。式変形統一では姉妹側「射影の代数」の残り
（$P^{(+)}+P^{(-)}=I$ と像の特徴づけ $\mathrm{im}\,P^{(\pm)}=\mathcal{F}^{(\pm)}$）を
一行一等号と行末根拠の鎖へ開き、同ブロックを完了した。次は同ファイルの次の根拠なしの鎖
（候補は「$\varepsilon$ は $V_1,V_2,V_1^{(\pm)}$ と可換」以降。機械走査で特定する）から続ける。

2026-08-13 の tick 203 は、「二次体の三分律（少なくとも一つ）」の Lean 具体版・必要十分版・
導出を完成させ、四層すべてを満たした。具体版は本文と同じく表示係数の符号で場合分けし、
同符号・零・混合符号を正錐、零表示、平方の大小比較へ帰着する。必要十分版は順序環、係数表示の
三条件、混合符号で二つの平方が一致しないことだけを要求し、導出は二次体の表示と「混合符号の
排除」を渡す。レビューでは前 tick の本文・SageMath と姉妹側の双曲線関数の式変形統一を
突き合わせ、修正不要と確認した。式変形統一では姉妹側「射影の代数」の冪等性と二方向の
直交性を、一行一等号と行末根拠を持つ三本の鎖へ開いた。次は同じ証明の「射影の和が単位行列」と
像の特徴づけから続ける。次の本文セクションは「二次体の三分律（高々一つ）」である。

2026-08-13 の tick 202 は、「二次体の三分律（少なくとも一つ）」
（`claim_quadratic_trichotomy_at_least_one`。$s\cdot s=2$ を満たす
$s\in\overline{\mathbb{Q}}$ と任意の $\xi\in Q_s$ について、$\xi\in P_s$・$\xi=0$・
$-\xi\in P_s$ の少なくとも一つ）を記述と SageMath まで進めた。証明は表示
$(a,b):=\mathrm{rep}_s(\xi)$ の符号による四つの場合分け（両方非負・両方非正・混合二つ）で、
零は零元の表示による特徴づけ、同符号は正錐の第一条件、混合符号は「混合符号の排除」で
$a\cdot a=2\cdot(b\cdot b)$ を除いた上で大小の二択により第二・第三条件を $\xi$ か $-\xi$ に
当てる。SageMath（`sagemath/check/quadratic-trichotomy-at-least-one/`）は $t^2-2$ の両根 ×
有理数標本で、少なくとも一つの判定 1458 組・場合分けの網羅 729 組・加法逆元の表示 1458 組・
混合符号の鎖 338 組を厳密検査して通過した。**Lean は未着手**で、次 tick はこの主張の
Lean（具体版・必要十分版・導出）を完成させる。レビューでは前 tick の「混合符号の排除」の
Lean 三本と姉妹側「$\sigma_m^z$ の基底への作用」の式変形統一を突き合わせ、修正不要と確認した。
式変形統一では姉妹側「$(2s_2)^{1/2}\cosh K_2^*=e^{K_2}$・$(2s_2)^{1/2}\sinh K_2^*=e^{-K_2}$」
（`010_transfer_matrix_bridge`）の一行複数等号の鎖五本を一行一等号と行末根拠へ開き、
同ブロックを完了した。次の統一は同ファイルの残りの根拠なしの鎖
（射影 $P^{(\pm)}$ の冪等・直交の計算など）から続ける。

2026-08-13 の tick 201 は、「混合符号の排除」の Lean 具体版・必要十分版・導出を完成させ、
四層すべてを満たした。具体版は本文と同じ六段の鎖を持つ。必要十分版は積・単位元、着目する
$b$ の右逆元、二つの積の並べ替え、六段の鎖の終点だけを要求し、体・加法・順序・可算性を
要求しない。三定理を本文・入口 import・sorry 非依存検査へ登録した。次は
「二次体の三分律（少なくとも一つ）」である。式変形統一では姉妹側
「$\sigma_m^z$ の基底 $f_{\iota(\mu)}$ への作用」を整えた。Pauli 行列の直接計算、定義の代入、
クロネッカー積の積、恒等作用、多重線型性、二作用の合成を一ステップ一定理の鎖へ分けた。

2026-08-13 の tick 201 のレビューで、前 tick の「混合符号の排除」の本文・SageMath は
主張・背理法の六段の鎖・厳密標本検査が一致すると確認した。一方、姉妹側「$V$ の固有値」の
式変形に、係数計算と和の線型性、および冪の法則と指数法則を一つの等号へまとめた箇所が
残っていたため、各操作を別の等号へ分けて一ステップ一定理へ修正し、前進前に反映した。

2026-08-13 の tick 200 は、「混合符号の排除」（`claim_rational_square_ne_double_square`。
任意の $a,b\in\mathbb{Q}$ について $b\ne0$ ならば $a\cdot a\ne2\cdot(b\cdot b)$）を記述と
SageMath まで進めた。証明は背理法で、乗法逆元 $b^{-1}$ から $r:=a\cdot b^{-1}$ を置き、
六段の鎖で $r\cdot r=2$ を導いて `claim_no_rational_square_two` と矛盾させる。三分律で
表示 $(a,b)$ の符号が混合する場合（正錐の第二・第三条件）の $a\cdot a$ と $2\cdot(b\cdot b)$
の大小比較が二つの厳密な場合で尽くされることの根拠になる。SageMath
（`sagemath/check/rational-square-ne-double-square/`）は分子・分母 1..20 の正負と 0 の
有理数の組 640800 組で主張と鎖の各段を厳密検査して通過した。**Lean は未着手**で、次 tick は
この主張の Lean（具体版・必要十分版・導出）を完成させる。レビューでは、前 tick の
必要十分版 `neg_mem_necSuf` が証明で使わない仮定を要求していたため削除し、前進前に push した。
式変形統一では姉妹側「$V$ の固有値」の証明を一行一等号と行末根拠へ整え、同ブロックを完了した。

2026-08-13 の tick 199 は、「三分律の準備（零元の特徴づけ・加法逆元の表示）」の Lean
具体版・必要十分版・導出を完成させ、四層すべてを満たした。レビューでは、前 tick の二ブロックが
それぞれ所属と表示の等式を同居させていたため、零元の所属・零元の表示による特徴づけ・加法逆元
による閉性・加法逆元の表示の四主張へ分割し、前進前に main へ反映した。具体版は本文と同じ表示の
鎖と表示の一意性を使う。必要十分版は二係数による表示・表示写像の仕様と一意性・零元または
加法逆元の表示だけを要求し、体・順序・代数閉性・可算性を要求しない。次は「混合符号の排除」。
式変形統一では姉妹側「$c=(2\sinh 2K_2)^{M/2}$」の逆行列の一意性、トレースの表示と二つの比を
一行一等号・行末根拠へ整え、同ブロックを完了した。

2026-08-13 の tick 198 は、セクション「二次体の三分律」を論法の数で四つ（三分律の準備・
混合符号の排除・少なくとも一つ・高々一つ）へ割り、先頭の「三分律の準備（零元の特徴づけ・
加法逆元の表示）」を記述と SageMath まで進めた。零元の特徴づけ
（`claim_quadratic_zero_representation`）は、$0=0+0\cdot s$ の鎖で $0\in Q_s$ を示し、
$\xi=0\iff\mathrm{rep}_s(\xi)=(0,0)$ の両方向を鎖と表示の一意性
（`claim_quadratic_representation_unique`）の適用で示す。加法逆元の表示
（`claim_quadratic_negation_representation`）は、$-(a+b\cdot s)=(-a)+(-b)\cdot s$ の三段の
鎖で $-\xi\in Q_s$ と $\mathrm{rep}_s(-\xi)=(-a,-b)$ を得る。どちらも三分律で「零」「加法の
逆元が正」を表示の組の条件として扱うための道具である。SageMath
（`sagemath/check/quadratic-zero-negation/`）は `QQbar` の 2 根 × 有理数標本で零元の特徴づけ
722 組・加法逆元の鎖 722 組・$\mathbb{Q}$ と $\overline{\mathbb{Q}}$ の逆元の両立 19 組を
厳密検査して通過した。**Lean は未着手**で、次 tick はこの二主張の Lean（具体版・必要十分版・
導出）を完成させる。レビューでは前 tick の「二次体の正錐の定義」の Lean 形式化と姉妹側の
$VW=I$ 補完・「符号反転共役 $U$」の統一を突き合わせ、修正不要と確認した。式変形統一では
姉妹側「$c=(2\sinh 2K_2)^{M/2}$」の Step 1・Step 2 の行末根拠を補い、Step 3 の逆行列の
一行複数等号を二本の五段の鎖へ開いた。同ブロックの残り（逆行列の一意性の散文内の等号鎖、
トレースの比）は次 tick が続ける。

2026-08-13 の tick 197 は、「二次体の正錐の定義」の Lean 形式化を完成させ、このセクションを
完了した。台集合、所属証拠を持つ元、表示写像とその仕様・一意性、表示係数の三つの正値条件、
正錐、生成元 $s$ の表示と正値性、根の取り替えに対する台集合の不変性を実装し、本文と sorry
検査へ登録した。レビューでは、姉妹側「$V$ は正定値、とくに $\mathrm{tr}(V)>0$」の逆行列候補に
ついて $WV=I$ しか書かれていなかったため、$VW=I$ も九段の鎖で補って前進前に push した。
式変形統一では姉妹側「符号反転共役 $U$」一ブロックを一行一等号と行末根拠へ整えた。次は
「二次体の三分律」、式変形統一は同ファイルの「$c=(2\sinh 2K_2)^{M/2}$」から続ける。

2026-08-13 の tick 196 は、セクション「二次体の正錐と三分律」を論法の数で二つ
（二次体の正錐の定義・二次体の三分律）へ割り、先頭の「二次体の正錐の定義」を記述と
SageMath まで進めた。台集合 $Q_s:=\{a+b\cdot s\mid a,b\in\mathbb{Q}\}$
（`def_quadratic_field_set`）、表示の写像 $\mathrm{rep}_s:Q_s\to\mathbb{Q}\times\mathbb{Q}$
（`def_quadratic_representation_map`。well-defined 性は
`claim_quadratic_representation_unique` から）、正錐 $P_s$
（`def_quadratic_positive_cone`。表示 $(a,b)$ の有理数の不等式三条件:
$0\le a,0\le b,(a,b)\ne(0,0)$／$0<a,b<0,2b^2<a^2$／$a<0,0<b,a^2<2b^2$）を定義し、
$\mathrm{rep}_s(s)=(0,1)$ が第一条件を満たすことでこの正錐が「$s$ を正と宣言する」選択で
あること、根の取り替え $s\mapsto-s$ で同じ構造が対で得られることを remark
（`remark_positive_cone_sign_choice`）に書いた。SageMath
（`sagemath/check/quadratic-positive-cone/`）は三条件と実代数的数 `AA` の厳密順序の一致
361 組・取り替えの恒等式 722 組・表示の一意性の対偶 1200 組を検査して通過した。
**Lean は未着手**で、次 tick はこの定義の Lean 形式化を書くか、続けて「二次体の三分律」を
進める。レビューでは前 tick の「二次体の表示の一意性」の Lean 三本と姉妹側の境界項の
根拠補いを突き合わせ、修正不要と確認した。式変形統一では姉妹側「$V$ は正定値、とくに
$\mathrm{tr}(V)>0$」を整えた。次 tick の式変形統一は同ファイルの次の根拠なしの鎖から続ける。

2026-08-13 の tick 195 は、「二次体の表示の一意性」の Lean 具体版・必要十分版・導出を
完成させ、四層すべてを満たした。具体版は本文の十四段の等式列、一次独立性の適用、二本の
六段の等式列を同じ順に実装した。必要十分版は係数側と値側の加法可換群、加法を保つ係数写像、
右から掛ける操作の加法・零元保存、一次独立性だけを要求し、乗法の結合則・単位元・可換性・
体・代数閉性・順序・可算性を要求しない。レビューでは本文の参照を囲む括弧の境界だけを修正し、
前進前に別コミットで push した。式変形統一では姉妹側「$iK_1H_1^{(\pm)}$ と $iK_2^*H_2$ は
実対称」に残っていた境界項 $Y_MZ_1$ の始点と終点へ根拠を補い、同ブロックを完了した。
次は「二次体の正錐と三分律」、式変形統一は姉妹側「$V$ は正定値、とくに
$\mathrm{tr}(V)>0$」である。

2026-08-13 の tick 194 は、セクション「二次体の正錐と三分律」から表示の一意性を独立の論法
として「二次体の表示の一意性」へ割り出し、それを記述と SageMath まで進めた。主張は、
$s\cdot s=2$ を満たす $s\in\overline{\mathbb{Q}}$ と任意の $a,b,a',b'\in\mathbb{Q}$ について
$a+b\cdot s=a'+b'\cdot s$ ならば $(a,b)=(a',b')$（`claim_quadratic_representation_unique`）。
証明は差 $\alpha:=a+(-a')$、$\beta:=b+(-b')$ を置き、十四段の鎖で $\alpha+\beta\cdot s=0$ を
導いて `claim_one_s_linearly_independent` を当て、六段の鎖二本で $a=a'$ と $b=b'$ を得る。
SageMath（`sagemath/check/quadratic-representation-unique/`）は `QQbar` の 2 根 × 有理数標本で
対偶 4704 組・鎖の恒等変形 4802 組・同一表示の場合 98 組を厳密検査して通過した。
**Lean は未着手**で、次 tick はこの主張の Lean（具体版・必要十分版・導出）を完成させる。
レビューでは前 tick の「一と $s$ の一次独立性」の Lean 三本と姉妹側「エルミート行列の
$\exp$ は正定値」(2)〜(4) を突き合わせ、修正不要と確認した。式変形統一では姉妹側
「$iK_1H_1^{(\pm)}$ と $iK_2^*H_2$ は実対称」の Step 0 の行列計算三本と Step 1・Step 2 の
散文内の等号鎖を一行一等号と行末根拠へ整えた。次 tick は同ファイルの次の根拠なしの鎖から続ける。

2026-08-13 の tick 193 は、「一と $s$ の一次独立性」の Lean 具体版・必要十分版・導出を
完成させ、四層すべてを満たした。具体版は本文と同じく $b\ne0$ から埋め込み像として $s$ を
表し、その平方を単射で有理数側へ戻して「有理数の平方は二にならない」と矛盾させ、最後に
$a=0$ を得る。必要十分版は体、単射な環準同型、平方が二になる元の不在だけを要求し、
代数閉性・順序・可算性を要求しない。レビューでは SageMath の移項の五段に各中間等式を直接
検査する 4324 組を補い、前進前に別コミットで push した。式変形統一では姉妹側
「エルミート行列の $\exp$ は正定値」の (2)〜(4) を一行一等号と行末根拠へ整え、同ブロックを
完了した。次は「二次体の正錐と三分律」、式変形統一は姉妹側の「$iH$ は実対称」である。

2026-08-13 の tick 192 は、セクション「一と $s$ の一次独立性」
（`claim_one_s_linearly_independent`）を記述と SageMath まで進めた。主張は、$s\cdot s=2$ を
満たす $s\in\overline{\mathbb{Q}}$ と任意の $a,b\in\mathbb{Q}$ について $a+b\cdot s=0$ ならば
$(a,b)=(0,0)$。証明は $b\ne0$ の背理法（移項の五段の鎖で $b\cdot s=-a$、逆元の五段の鎖で
$s=b^{-1}\cdot(-a)=:r\in\mathbb{Q}$、$r\cdot r=2$ が `claim_no_rational_square_two` と矛盾）と、
$b=0$ のもとでの四段の鎖 $a=0$ である。SageMath
（`sagemath/check/one-s-linearly-independent/`）は `QQbar` の 2 根 × 有理数標本で対偶 4416 組・
$b\ne0$ の鎖 4324 組・$b=0$ の段 92 組を厳密検査して通過した。**Lean は未着手**で、次 tick は
この主張の Lean（具体版・必要十分版・導出）を完成させる。レビューでは前 tick の
「有理数の平方は二にならない」の Lean 三本（終端の整数矛盾は既存流儀どおり omega）と姉妹側
「$\|A^*\|=\|A\|$ と極限の共役転置」(2)(3) を突き合わせ、修正不要と確認した。式変形統一では
姉妹側 `009_eigenvalues_of_V` の「エルミート行列の $\exp$ は正定値」の (1)（エルミート性の
二本の鎖・指数の積の二本の鎖・正定値性の七段の鎖）を一行一等号と行末根拠へ整えた。次 tick は
同ブロックの (2)〜(4) から続ける。

2026-08-13 の tick 191 は、「有理数の平方は二にならない」の Lean 具体版・必要十分版・導出を
完成させ、四層すべてを満たした。具体版は本文と同じく符号で正の有理数へ帰着し、素数 $2$ の
対数成分から $1=m+m$ を得て整数の順序で矛盾させる。必要十分版は符号の三分、負数から正数への
帰着、指数の二倍による矛盾だけを残し、導出は具体版の各段を渡す。レビューでは前 tick の本文・
SageMath と姉妹側「$\|A^*\|=\|A\|$ と極限の共役転置」(1) を突き合わせ、本文の $q=0$、
負数から正数への帰着、整数の大小による矛盾に残っていた一行複数等号を修正して前進前に push した。
式変形統一では姉妹側の同じ証明ブロックの (2)(3) を一行一等号と行末根拠へ整え、ブロック全体の
統一を完了した。次は「一と $s$ の一次独立性」であり、式変形統一は同ファイルの次の証明ブロック
から続ける。

2026-08-13 の tick 190 は、セクション「正の根の特定 $x_c=\sqrt2-1$ と順序の導入」を論法の数で
五つ（有理数の平方は二にならない・一と $s$ の一次独立性・二次体の正錐と三分律・
正錐と加法・乗法の両立・正の根の特定 $x_c=\sqrt2-1$）へ割り、先頭の
「有理数の平方は二にならない」（`claim_no_rational_square_two`）を記述と SageMath まで進めた。
証明は、符号の場合分けで $q\cdot q=2$ を満たす正の有理数 $r$ へ帰着し、素数 $2$ での指数を
数える九段の鎖（`def_prime_exponent`・`def_rational_log`・`claim_log_additive` を引く）で
$1=m+m$（$m:=w_2(r)\in\mathbb{Z}$）を導き、整数の順序の場合分けで矛盾させる背理法である。
SageMath（`sagemath/check/no-rational-square-two/`）は `QQ`/`ZZ` の 3200 個の有理数で
主張と鎖の全段を厳密検査して通過した。**Lean は未着手**で、次 tick はこの主張の Lean
（具体版・必要十分版・導出）を完成させる。順序の入れ方は「$s$ を正と宣言する正錐を
表示 $(a,b)$ の有理数の不等式で置く」設計に決めた（台帳のセクション表の備考が正本）。
レビューでは前 tick の「自己双対方程式の因数分解と根の全体」の Lean 三本と姉妹側
「$\mathrm{tr}(V')>0$」の書式変更を突き合わせ、修正不要と確認した。式変形統一では姉妹側
`009_eigenvalues_of_V` の「$\|A^*\|=\|A\|$ と極限の共役転置」(1) の五等号の鎖を
一行一等号と行末根拠へ開いた。次 tick は同ファイルの次の根拠なしの鎖から続ける。

2026-08-13 の tick 189 は、「自己双対方程式の因数分解と根の全体」の二主張について Lean
具体版・必要十分版・導出を完成させ、四層すべてを満たした。具体版は本文と同じ因数分解、
零因子の場合分け、二根の相異の背理法を実装し、必要十分版はその論理的な含意だけへ薄めた。
六定理を本文と sorry 検査へ登録した。レビューでは前 tick の本文・SageMath と姉妹側
「$V'$ の固有値」の書式変更を突き合わせ、修正不要と確認した。式変形統一では姉妹側
`009_eigenvalues_of_V` の「$\mathrm{tr}(V')=\mathrm{tr}(V'^{-1})>0$」を一行一等号と
行末根拠へ整えた。次は「正の根の特定 $x_c=\sqrt2-1$ と順序の導入」であり、式変形統一は
同ファイルの次の証明ブロックから続ける。

2026-08-13 の tick 188 は、セクション「自己双対方程式の因数分解と根の全体」を記述と
SageMath まで進めた。主張は二ブロックに分けた。因数分解の主張
（`claim_self_dual_quadratic_roots`）は、$s\cdot s=2$ を満たす $s\in\overline{\mathbb{Q}}$
について、任意の $\xi\in\overline{\mathbb{Q}}$ で $\xi^2+2\xi-1=0$ と
「$\xi=-1+s$ または $\xi=-1-s$」が同値であること。準備で因数分解
$((\xi+1)-s)\cdot((\xi+1)+s)=\xi^2+2\xi-1$ を十四段の鎖で立て、第一の方向は各根で
対応する因子を零へ落とし、第二の方向は第一因子の零・非零の場合分けと零因子の不在
（`claim_qbar_no_zero_divisors`）で第二因子を消す。二根の相異の主張
（`claim_self_dual_quadratic_roots_distinct`）は $-1+s\ne-1-s$（背理法。$s=-s$ から
$2\cdot s=0$、零因子の不在で $s=0$、$2=0$ の矛盾）で、あわせて根はちょうど二つである。
SageMath（`sagemath/check/self-dual-quadratic-roots/`・
`sagemath/check/self-dual-quadratic-roots-distinct/`）は `QQbar` で $s$ の 2 通り × 19 点の
全段を厳密検査して通過した。**Lean は未着手**で、次 tick はこの二主張の Lean
（具体版・必要十分版・導出）を完成させる。レビューでは前 tick の「二の平方根の存在」の
Lean 三本と姉妹側「射影の代数」Step 1–5 を突き合わせて修正不要と確認した。
式変形統一では姉妹側 `009_eigenvalues_of_V` の「$V'$ の固有値」の証明（Step 1〜4）を
一行一等号と行末根拠へ整えた。次 tick は同ファイルの
「$\mathrm{tr}(V')=\mathrm{tr}(V'^{-1})>0$」以降の根拠なしの鎖から続ける。

2026-08-13 の tick 187 は、「二の平方根の存在」の Lean 具体版・必要十分版・導出を完成させ、
四層すべてを満たした。具体版は本文と同じ二次係数の四段、代数閉性による根の取り出し、
評価写像の十一段を実装した。必要十分版は同じ手順を零元・等式・含意だけへ薄め、導出は
具体版の各段をそのまま渡す。レビューでは本文・SageMath と姉妹側「射影の代数」Step 0 を
突き合わせて数学内容は修正不要と確認し、台帳の tick 185 の現在地見出し欠落だけを前進前に
修復して push した。式変形統一では姉妹側 `009_eigenvalues_of_V` の「射影の代数」の
Step 1 から Step 5 を一行一等号と行末根拠へ整えた。次は「自己双対方程式の因数分解と根の
全体」であり、式変形統一は同ファイルの「$V'$ の固有値」から続ける。

2026-08-13 の tick 186 は、セクション「自己双対方程式の二根と $x_c=\sqrt2-1$ の特定」を
論法の数で三つ（二の平方根の存在・自己双対方程式の因数分解と根の全体・正の根の特定と
順序の導入）へ割り、先頭の「二の平方根の存在」（$s\cdot s=2$ を満たす
$s\in\overline{\mathbb{Q}}$ の存在。`claim_sqrt_two_exists`）を記述と SageMath まで進めた。
証明は、多項式 $g:=t^2+\widehat{-2}\in\overline{\mathbb{Q}}[t]$ の係数
$\mathrm{ac}_2(g)=1\ne0$ を四段の鎖で立てて次数 1 以上を確かめ、`def_algebraic_numbers` の
代数閉性で根 $s$ を取り、$s\cdot s$ から $2$ までを評価写像 `def_qbar_poly_evaluation` の
性質だけで結ぶ十一段の鎖である。どちらの根を $\sqrt2$ と呼ぶかは特定しない（二根は体の
自己同型で移り合うため、特定には実代数的数の順序が要る。順序の導入は三つめのセクションで
行う）。SageMath（`sagemath/check/sqrt-two-exists/`）は `QQbar` で $t^2-2$ の 2 根を列挙し、
両方の根で鎖の全段を厳密検査して通過した。**Lean は未着手**で、次 tick はこの主張の
Lean（具体版・必要十分版・導出）を完成させる。レビューでは前 tick の「自己双対条件は
二次方程式と同値」の Lean 三本と姉妹側の場合分けの補いを突き合わせて修正不要と確認した。
式変形統一では姉妹側 `009_eigenvalues_of_V` の「射影の代数」の Step 0 の四本
（$R_\mu^{(e)}$ の冪等性二本・直交二本・和が単位行列）を一行一等号と行末根拠へ開いた。
次 tick は同じ証明の Step 1 以降の根拠なしの鎖から続ける。

2026-08-13 の tick 185 は、セクション「自己双対条件 $\mathrm{KW}(\xi)=\xi$ は
$\xi^2+2\xi-1=0$ と同値」の Lean 具体版・必要十分版・導出を完成させ、四層すべてを満たした。
具体版は本文の準備の積、第一の方向の二本の鎖、第二の方向の七段の鎖と零因子の消去を一段ずつ
実装した。必要十分版は同じ手順を等式と含意だけへ薄め、導出は具体版の各段をそのまま渡す。
レビューでは前 tick の本文・SageMath と姉妹側の書式変更を突き合わせて修正不要と確認した。
式変形統一では姉妹側 `009_eigenvalues_of_V` の「数演算子の積のトレース」を整えた際、
任意の $e_j\in\{0,1\}$ を主張する証明が全因子 $n_{\mu_j}$ の場合しか示していない欠落を見つけ、
$e_1=1$ と $e_1=0$ の両場合を帰納法へ接続した。次は「自己双対方程式の二根と
$x_c=\sqrt2-1$ の特定」であり、直前の Lean 三本を本文と突き合わせてから着手する。

2026-08-13 の tick 184 は、セクション「自己双対条件 $\mathrm{KW}(\xi)=\xi$ は
$\xi^2+2\xi-1=0$ と同値」（`claim_kw_self_dual_quadratic_equivalence`）を記述と SageMath まで
進めた。証明は、仮定によらない準備の等式 $\mathrm{KW}(\xi)\cdot(1+\xi)=1-\xi$ を五段の鎖で
立て、第一の方向（$\mathrm{KW}(\xi)=\xi\Rightarrow\xi^2+2\xi-1=0$）は
$\xi\cdot(1+\xi)=1-\xi$ を経て二次式を零へ落とし、第二の方向は恒等式
$(1+\xi)\cdot(\mathrm{KW}(\xi)-\xi)=-(\xi^2+2\xi-1)$ と仮定から積を零とし、零因子の不在
（`claim_qbar_no_zero_divisors`）で差を消す。同値の二方向は一続きにつながず、各方向の中の
計算だけを一続きの鎖で書いた。全過程は体 $\overline{\mathbb{Q}}$ の加法・積・逆元で閉じる。
SageMath（`sagemath/check/kw-self-dual-quadratic-equivalence/`）は定義域検査の 16 点に
自己双対方程式のもう一方の根 $-1-\sqrt2$ を加えた 17 点で、同値の成立側がちょうど 2 根で
あることと鎖の中間段を厳密検査して通過した。**Lean は未着手**で、次 tick はこの主張の
Lean（具体版・必要十分版・導出）を完成させる。レビューでは前 tick の「双対変換の対合性」の
Lean 三本を本文と突き合わせて修正不要と確認した。式変形統一では姉妹側
`009_eigenvalues_of_V` の「数演算子の交換 $n_\mu n_\nu=n_\nu n_\mu$」の証明で、Step 2 の
根拠なしの三行へ行末根拠を付け、Step 3 の六等号の鎖を一行一等号と行末根拠へ開いた。
次 tick は同ファイルの次の根拠なしの鎖（数演算子の積のトレース $2^{M-k}$ のあたり）から続ける。

2026-08-13 の tick 183 は、「双対変換の対合性」の Lean 具体版・必要十分版・導出を完成させ、
四層すべてを満たした。具体版は本文の二本の積の鎖と差の鎖を一段ずつ実装し、必要十分版は
二本の積の鎖の結論を差の置換へ必須入力として接続した。レビューでは前 tick の本文・SageMath・
姉妹側の式変形統一を突き合わせて修正不要と確認した。次は「自己双対条件
$\mathrm{KW}(\xi)=\xi$ は $\xi^2+2\xi-1=0$ と同値」である。式変形統一では姉妹側
`009_eigenvalues_of_V` の「$n_\mu^2=n_\mu$」の証明に残っていた行末根拠を補った。

2026-08-13 の tick 182 は、セクション「双対変換の対合性 $\mathrm{KW}(\mathrm{KW}(\xi))=\xi$」
（`claim_kw_dual_transform_involution`）を記述と SageMath まで進めた。証明は、準備で
$1+\mathrm{KW}(\xi)=2(1+\xi)^{-1}$ と $1-\mathrm{KW}(\xi)=2\xi(1+\xi)^{-1}$ の二つの鎖を立て、
$\mathrm{KW}(\mathrm{KW}(\xi))\cdot(1+\mathrm{KW}(\xi))$ と $\xi\cdot(1+\mathrm{KW}(\xi))$ が
どちらも $1-\mathrm{KW}(\xi)$ に等しいことを示し、差に $1+\mathrm{KW}(\xi)$ を掛けて零とし、
零因子の不在（`claim_qbar_no_zero_divisors`）で差を消す組み立てである。逆元どうしの計算
（$(2(1+\xi)^{-1})^{-1}$ の明示計算）を避けたので、逆元の一意性の補題は要らなかった。
全過程は体 $\overline{\mathbb{Q}}$ の加法・積・逆元で閉じる。SageMath
（`sagemath/check/kw-dual-transform-involution/`）は定義域検査と同じ `QQbar` の 16 点で
主張と中間段五つを厳密検査して通過した。**Lean は未着手**で、次 tick はこの主張の
Lean（具体版・必要十分版・導出）を完成させる。レビューでは前 tick の「双対変換の定義域保存」の
Lean 三本を本文と突き合わせて修正不要と確認した。式変形統一では姉妹側
`009_eigenvalues_of_V` の「トレースの基本性質」の証明で、(2) 巡回性の最終行へ根拠を付け、
(4) の一行に潰れていた五等号の鎖を一行一等号と行末根拠へ開いた。次 tick は同ファイルの
残りの根拠なしの鎖（$n_\mu^2=n_\mu$、反交換子四式、$A n_\nu$ の交換、射影の代数、
$\mathrm{tr}(Q_\epsilon)$ など機械走査で多数残る）から続ける。

2026-08-13 の tick 181 は、「双対変換の定義と、値が定義域に留まること」の Lean 具体版・
必要十分版・導出を完成させ、四層すべてを満たした。具体版は本文どおり、
$1+\mathrm{KW}(\xi)=2(1+\xi)^{-1}$ の三段の式変形、零因子の消去、逆元の等式による背理法を
一行ずつ実装した。必要十分版は、三組の等式、「終点が零なら逆元が零」「逆元が零なら単位元が零」
という二つの含意、単位元の非零性だけへ薄めた。レビューでは前 tick の本文と SageMath を
突き合わせて修正不要と確認した。次は「双対変換の対合性
$\mathrm{KW}(\mathrm{KW}(\xi))=\xi$」である。式変形統一では姉妹側の定義「フェルミオン」の
$P_\mu$ 代入式へ行末根拠を付け、`008_TV1_hatZ_hatY_part2` について引き継がれた根拠なしの鎖を
処理し終えた。次 tick は次の本文ファイルから走査を続ける。

2026-08-13 の tick 180 は、セクション「自己双対点 $x_c=\sqrt2-1$」を論法の数で四つ
（双対変換の定義と値が定義域に留まること・双対変換の対合性・自己双対条件が
$\xi^2+2\xi-1=0$ と同値であること・自己双対方程式の二根と $x_c$ の特定）へ割り、先頭の
「双対変換の定義と、値が定義域に留まること」を記述と SageMath まで進めた。
双対変換 $\mathrm{KW}(\xi):=(1-\xi)\cdot(1+\xi)^{-1}$ を体 $\overline{\mathbb{Q}}$ の
演算で定義し（`def_kw_dual_transform`）、$1+\xi\ne0$ ならば
$1+\mathrm{KW}(\xi)=2\cdot(1+\xi)^{-1}\ne0$（`claim_kw_dual_transform_domain`）を、
準備（$2\ne0$・$1\ne0$・逆元の等式）と分配則の鎖、零因子の不在による背理法で示した。
SageMath は `QQbar` の 16 点（有理数・実代数的数・虚代数的数）で厳密検査して通過した。
**Lean は未着手**で、次 tick はこの主張の Lean（具体版・必要十分版・導出）を完成させる。
末尾のセクション「二根と $x_c$ の特定」には注意点がある: 二根 $-1\pm\sqrt2$ は
$\overline{\mathbb{Q}}$ の中では体の自己同型で移り合うため、「正の根」の特定には
実代数的数の順序が要る。順序の入れ方は着手時に決める（台帳の備考にも書いた）。
レビューでは前 tick の「四境界条件の混合の双対恒等式」の Lean 三本を本文と突き合わせ、
修正不要と確認した。式変形統一では姉妹側の「$\psi$ の反交換関係」の証明に残っていた
フェルミオンの表示二式へ行末根拠を付けた。機械走査で `008_TV1_hatZ_hatY_part2` に残る
根拠なしの鎖は、定義「フェルミオン」の $P_\mu$ 代入の一式だけになった。次はそこから続ける。

2026-08-13 の tick 179 は、「四境界条件の混合の双対恒等式」の Lean 具体版・必要十分版・導出を
完成させ、四層すべてを満たした。具体版は本文どおり、高温展開の四セクター分解、高温展開の
多項式恒等式、低温展開の自明セクター表示、冪の指数法則を四段の等式として順に適用する。
必要十分版は同じ型の五つの元と隣り合う四組の等式だけを仮定し、加法・乗法・冪・整数係数多項式・
格子・境界セクターの構造をすべて外した。導出は具体版の四段をそのまま必要十分版へ渡す。
レビューでは前 tick の本文と独立な SageMath 検算を参照先の三主張と突き合わせ、修正不要と
確認した。次は「自己双対点 $x_c=\sqrt2-1$」である。式変形統一は姉妹側の
「$\gamma_2(\theta_\mu)=0$ のとき $T_{(V')}$ は $\hat Z_\mu^{(-)},\hat Y_\mu$ を固定する」の
Step 3 に残っていたフェルミオンの表示二式と反交換子四式へ行末根拠を付けた。次は
`008_TV1_hatZ_hatY_part2` に残る根拠なしの式から続ける。

2026-08-13 の tick 178 は、「四境界条件の混合の双対恒等式」
$H^{0,0}_L+H^{0,1}_L+H^{1,0}_L+H^{1,1}_L=2^{L^2+1}G^{0,0}_L$ を記述と SageMath まで進めた。
証明は既存の三主張（高温展開の四セクター分解・高温展開の多項式恒等式 $2^{L^2}Z_L=H_L$・
低温展開の自明セクター表示 $Z_L=2G^{0,0}_L$）と冪の指数法則を当てる四段の鎖である。
周期正方格子は平面グラフではないため、一つのセクター多項式どうしの等式ではなく、四つの
境界条件の混合が自明セクターと結ばれる形になる。SageMath は $L=1,2,3$ で左辺・右辺と
鎖の中間段を `ZZ[x]` の厳密計算で突き合わせて通過した。**Lean は未着手**で、次 tick は
この主張の Lean（具体版・必要十分版・導出）を完成させる。レビューでは前 tick の Lean 三本
（四セクター分解）を本文と突き合わせ、必要十分版が三段の自前の calc であること、sorry 検査の
登録、本文の `lean` フィールドを含めて修正不要と確認した。式変形統一では姉妹側の
「$c_1=s_1c_2$ は臨界条件 $s_1s_2=1$ と同値」の Step 1 の根拠なしの等式列を二本の
一行一等号の鎖へ分け、Step 2 へ行末根拠を付けた。次は `008_TV1_hatZ_hatY_part2` の残り
（機械走査で 15 箇所の根拠なしの鎖が残る。$\det$ の展開・偏角の場合分けなど）から続ける。

2026-08-13 の tick 177 は、「高温展開の生成多項式を四つのセクターの生成多項式の和へ
分解する」の Lean 具体版・必要十分版・導出を完成させ、四層すべてを満たした。具体版は
偶部分グラフの有限集合を二つの巻き付き偶奇の値で四つのファイバーへ分け、各ファイバーへ
同じ整数多項式重みを足す。必要十分版は、勝手な有限集合・有限なラベル型・可換加法モノイド値の
重みについて、各項をそのラベルだけで値を持つ有限和へ開き、有限和の順序を交換し、ラベルの
ファイバーへ絞る手順に薄めた。レビューでは前 tick の本文・SageMath・既存定義を突き合わせ、
$L=1$ の番号付き自己ループ二本を含めて修正不要と確認した。次は「四境界条件の混合の
双対恒等式の組み立て」である。式変形統一では姉妹側の「$T_{(V)}=T_{(V')}$」の定義適用・
終点・二つの復元式へ行末根拠を補い、復元式を一行一等号へ分けた。

2026-08-13 の tick 176 は、「高温展開の生成多項式を四つのセクターの生成多項式の和へ分解する」を
記述と SageMath まで進めた。高温展開のセクター多項式 $H^{a,b}_L\in\mathbb{Z}[x]$
（セクター $\mathcal{E}^{a,b}_L$ だけにわたる $(1+x)^{2L^2-|A|}(1-x)^{|A|}$ の有限和）を定義し、
偶部分グラフの全体が四セクターの重なりのない合併であること（セクターの定義の偶性と分割の
一意存在の主張）で有限和を分割して $H_L=H^{0,0}_L+H^{0,1}_L+H^{1,0}_L+H^{1,1}_L$ を得た。
SageMath は $L=1,2,3$ で全辺部分集合から独立に数え上げて `ZZ[x]` で突き合わせて通過した。
**Lean は未着手**で、次 tick はこの主張の Lean（具体版・必要十分版・導出）を完成させる。
レビューでは、前 tick の必要十分版（有限和の添字交換）が mathlib の `Finset.sum_nbij'` を
そのまま当てる一行の別名になっていたため、始域についての帰納法による自前の証明へ書き直して
前進前に独立して反映した（主張と呼び出し側は不変）。式変形統一では、姉妹側の
「$T_{(V)}$ と $T_{(V')}$ は $\hat Z^{(-)},\hat Y$ 上で一致する」に残っていた $\det P_\mu$ の
計算を最終形まで一行一等号で完成させ、この証明ブロックを完了した。次は
「$T_{(V)}=T_{(V')}$」から続ける。

2026-08-13 の tick 175 は、「セクターごとの生成多項式と、低温展開の自明セクター表示」の
Lean 具体版・必要十分版・導出を完成させ、四層すべてを満たした。双対辺写像が
`attainableBrokenDualFinset L` と `trivialSectorFinset L` の間で互いに逆になり、辺数を保つことから
有限和を取り替え、既存の $Z_L=2D_L$ と合わせて $Z_L=2G_L^{0,0}$ を得た。必要十分版は、二つの
有限集合間の互いに逆な写像と重み保存だけで成り立つ有限和の添字交換である。レビューでは
前 tick の記述と SageMath を双対辺写像・切断辺集合・$L=1$ の番号付き自己ループまで突き合わせ、
修正不要と確認した。次は「高温展開の生成多項式を四つのセクターの生成多項式の和へ分解する」。
式変形統一では、姉妹側の「$\gamma_2(\theta_\mu)=0$ のとき $T_{(V')}$ は
$\hat Z_\mu^{(-)},\hat Y_\mu$ を固定する」の等号列を一行一等号へ整えた。次は
「$T_{(V)}$ と $T_{(V')}$ は $\hat Z^{(-)},\hat Y$ 上で一致する」である。

2026-08-13 の tick 174 は、「セクターごとの生成多項式と、低温展開の自明セクター表示」を
記述と SageMath まで進めた。四セクターの生成多項式 $G^{a,b}_L\in\mathbb{Z}[x]$ を定義し、
双対辺写像が誘導する $\mathfrak{B}_L\to\mathcal{E}^{0,0}_L$ の全単射（全射性は前セクションの
集合の等号、単射性は往復の等式、個数保存は単射性）で有限和の添字を取り替え、既存の
$Z_L=2D_L$ から $Z_L=2G^{0,0}_L$ を得た。SageMath は $L=1,2,3$ で全辺部分集合からの
$G^{a,b}_L$ と全配位からの $Z_L$・$D_L$ を `ZZ[x]` で突き合わせて通過した。
**Lean は未着手**で、次 tick はこの主張の Lean（具体版・必要十分版・導出）を完成させる。
レビューでは前 tick の Lean 三本と本文の対応を突き合わせ、修正不要と確認した。
式変形統一では姉妹側の「$\gamma_2(\theta_\mu)=0$ のとき $A(\theta_\mu)=I$」の三つの Step を
一行一等号の鎖へ整えた。次は「$\gamma_2(\theta_\mu)=0$ のとき $T_{(V')}$ は
$\hat{Z}_\mu^{(-)},\hat{Y}_\mu$ を固定する」である。

2026-08-13 の tick 173 は、「実現できる破れた辺集合の双対像は自明セクターの全体である」の
Lean 具体版・必要十分版・導出を完成させ、四層すべてを満たした。順方向は双対破れ像の
偶部分グラフ性と二つの巻き付き偶奇の零性、逆方向は自明セクターから配位を復元する既存定理の
原像が非空であることを使う。必要十分版は有限集合の像と適格条件による絞り込みの一致まで薄めた。
レビューでは前 tick の記述・SageMath・既存定義を突き合わせ、$L=1$ の番号付き自己ループを
含めて修正不要と確認した。式変形統一では姉妹側の「$T_{(V')}$ の $\psi$ への作用」の
Step 1'--5' を一行一等号へ整え、この証明ブロックを完了した。次は「セクターごとの生成多項式と、
低温展開の自明セクター表示」であり、式変形統一の次は「$\gamma_2(\theta_\mu)=0$ のとき
$A(\theta_\mu)=I$」である。

2026-08-13 の tick 172 は、旧セクション「非自明な三セクターと双対恒等式」を論法の数で四つ
（実現できる破れた辺集合の双対像は自明セクターの全体である・セクターごとの生成多項式と
低温展開の自明セクター表示・高温展開の生成多項式の四セクター分解・四境界条件の混合の
双対恒等式の組み立て）へ割り、先頭の両包含の主張を記述と SageMath まで進めた。一方の包含は
双対破れ像の偶性と巻き付き零性、他方は配位復元の原像の非空性から従う。SageMath は
$L=1,2,3$ で双対像の集合と自明セクターの全体の一致を厳密検査した。Lean は未着手で、
次 tick はこの主張の Lean（具体版・必要十分版・導出）を完成させる。レビューでは、
前 tick が四層完了させた配位復元の主張ブロックに `lean` フィールドが欠けていたのを補い、
前進前に独立して push した。式変形統一では姉妹側の「$T_{(V')}$ の $\psi$ への作用」の
Step 5 の結論の鎖を一行一等号の六段へ整えた。

2026-08-13 の tick 171 は、「自明セクターの偶部分グラフから配位を復元できる」の残る
復元組み立てを Lean で完了し、セクションを四層すべて完了した。道和の偶奇をスピン値へ戻し、
横向き・縦向きの辺差から破れた辺集合が双対写像で戻した辺集合に一致すること、したがって
双対破れ像がもとの自明セクターに一致する配位が存在することを示した。既存の全スピン反転と
原像の一意性の必要十分版から元の個数が二つであることを得る。次は、非自明な三セクターを
捨てず、四境界条件の混合として低温展開と高温展開を結ぶ可算な双対恒等式である。
レビューでは前 tick の縦向き辺差を本文と突き合わせて数学的修正不要と確認し、Lean 冒頭の
実装状況だけを直した。式変形統一では姉妹側の「$T_{(V')}$ の $\psi$ への作用」の Step 4 を整えた。

2026-08-13 の tick 170 は、縦向き辺の道和差 $t(i+\bar1,j)+t(i,j)=b_{\mathrm v}(i,j)$ を
Lean 具体版で完了した。隣り合う二項の和の望遠鏡和が $\mathbb Z/2\mathbb Z$ で両端の
二項だけを残す補題を帰納法で置き、格子面の等式で横辺二項の和を縦辺二項の和へ移して
横向きの有限和の差を列 $0$ と列 $j$ の縦辺二項へ落とし、縦向きの有限和の差は代表の
場合分け（末尾未満は末尾の一項、末尾は列全体の和の零性）で列 $0$ の項にした。
sorry 検査は 752 件で通過した。存在構成の残りは復元の組み立て（道和から定めた配位の
破れた辺集合が復元した辺集合に一致すること）だけで、次 tick はそこを形式化する。
レビューでは Lean 冒頭の残作業の説明を実装済み範囲へ合わせた。式変形統一では姉妹側の
「$T_{(V')}$ の $\psi$ への作用」の Step 3 を整えた。

2026-08-13 の tick 169 は、道和の定義と横向き辺の差を Lean 具体版で完了した。
`ZMod.val` 代表に沿う縦向きと横向きの二本の有限和として基点付き道和を定義し、
横座標が末尾未満な場合は有限和の末尾の一項、末尾の場合は全行和の零性から、
隣接頂点の道和の差が横辺の所属指示子に等しいことを示した。次 tick は縦向き辺の差を
形式化する。sorry 検査は 750 件で通過した。レビュでは Lean 冒頭の残作業の説明を実装済み範囲へ合わせた。式変形統一では
姉妹側の「$T_{(V')}$ の $\psi$ への作用」の Step 2 の結論を三段の鎖へ開いた。

2026-08-13 の tick 168 は、配位復元の存在構成の残り「道和と辺差の等式」を論法の数で三つ
（全行・全列の周期和の零性・道和の定義と横向き辺の差・縦向き辺の差）へ割り、先頭の
「全行・全列の周期和の零性」を Lean 具体版で完了した。二周期の等式を出発点、行和・列和の
不変性を一歩とする自然数の帰納法（$-1+n$ の形）で、任意の行の横辺和と任意の列の縦辺和が
零であることを示した。sorry 検査は 749 件で通過。次 tick は道和の定義と横向き辺の差の
等式を形式化する。レビューでは、前 tick の二周期・行和列和の Lean が本文と一致することを
確認し、実装に追いついていなかったファイル冒頭の説明を直した。式変形統一では姉妹側の
「$T_{(V')}$ の $\psi$ への作用」の Step 2 の冒頭の鎖と $\gamma_2$ の周期性の二本を
一行一等号へ開いた。

2026-08-13 の tick 167 は、配位復元の存在構成のうち「二周期と行和・列和の等式」を
Lean 具体版で完了した。自明セクターの巻き付き偶奇を双対辺写像の逆写像で復元辺集合の
二つの周期閉路和へ戻し、格子面等式の一周期和、周期添字のずらし、$2=0$
（$\mathbb Z/2\mathbb Z$）から横辺の行和と縦辺の列和がそれぞれ不変であることを示した。
sorry 検査は 748 件で通過した。次 tick は道和と辺差の等式を形式化する。
式変形統一では姉妹側の $\gamma_2$ の周期性を
二つの連続した等号列へ開いた。

2026-08-13 の tick 167 のレビューでは、配位復元の格子面等式を本文・SageMath・Lean で
突き合わせ、四指示子の順序と結論が一致することを確認した。一方、Lean ファイル冒頭は
「個数計算だけを置き、存在構成は後続 tick で加える」と書かれたまま、既に格子面等式まで
実装済みだったため、実装済みの範囲と残る三論法を正しく示す説明へ直した。

2026-08-12 の tick 166 は、配位復元セクションの存在構成の Lean を論法の数で四つ
（格子面の等式・二周期と行和列和の等式・道和と辺差の等式・復元の組み立て）へ割り、先頭の
「格子面の等式」を具体版で完了した。復元した辺集合 `reconstructedEdgeSet`
（人手証明の $B=\delta_L^{-1}(A)$）と往復の等式を置き、双対像の局所端点数を任意の辺集合の
四つの所属指示子で書く一般化補題を経て、偶部分グラフであることだけから格子面の四指示子の
$\mathbb Z/2\mathbb Z$ 和が零であることを導いた。sorry 検査は 746 件で通過。
次 tick は二周期の等式と行和・列和の望遠鏡和を形式化する。レビューでは、必要十分版の
ファイル冒頭コメントの「対合」（定理は対合性を仮定しない）と、台帳整理で落ちていた
進行中セクション行を直した。式変形統一では姉妹側の「$T_{(V)}$ と $T_{(V')}$ は
$\hat Z^{(-)},\hat Y$ 上で一致する」の場合 2（$\gamma_2(\theta_\mu)=0$）を三段の鎖へ開いた。

2026-08-12 の tick 165 は、配位復元セクションの Lean 個数部分を進めた。復元した配位が一つ
存在すれば、全スピン反転が異なる第二の原像を与え、同じ双対破れ像を持つ配位はこの二つだけで
あることを具体版・必要十分版・導出で示した。必要十分版が要求するのは、有限写像の値を保つ
不動点のない対と、その対による原像の一意性だけである。基点からの道和による最初の配位の
存在構成は Lean 未了なので、次 tick はそこを本文と一対一に形式化する。式変形統一では姉妹側の
$\hat Y_\mu$ の作用を五段の鎖へ整えた。

2026-08-12 の tick 165 のレビューでは、前 tick の配位復元証明にある格子面条件・二周期条件・
横向き辺の道和差へ根拠を補い、二つの適用をまとめていた最後の双対像の等式を二段へ分けた。
結論と SageMath の有限検算には変更がない。

2026-08-12 の tick 164 は、「自明セクターの偶部分グラフから配位を復元する」を記述と SageMath
まで進めた。双対写像で戻した辺集合について、格子面の偶数性と二周期の零偶奇から基点付きの
道和でスピンを構成し、既存の全スピン反転と破れた辺集合の一意性から原像が二配位だけと示した。
SageMath は $L=1,2,3$ の自明セクター全体を厳密検査した。Lean 具体版・必要十分版・導出は未着手で、
次 tick はこの三本を完成させる。式変形統一では姉妹側の復元後の作用を整えた。

2026-08-12 の tick 164 のレビューでは、前 tick の巻き付き偶奇の人手証明がスピン積の相殺、
Lean が二値を $\mathbb Z/2\mathbb Z$ に符号化した有限和の添字交換という別の手順だったため、
本文を Lean と同じ手順へ直した。結論と SageMath の境界辺対応には変更がない。

2026-08-12 の tick 163 は、「破れた辺の双対像の二つの巻き付き偶奇は零である」を
四層すべてで完了した。横向き境界の双対辺は元の縦向き周期閉路へ、縦向き境界の双対辺は
元の横向き周期閉路へ戻る。有限集合上の置換に沿う二値の変化回数は偶数であるという
必要十分版を二方向へ適用した。次は、自明セクターの偶部分グラフから配位を復元する。
レビューした前 tick の偶部分グラフ性には修正箇所が無かった。式変形統一では姉妹側の
$P_\mu^{-1}$ による復元の鎖を整えた。

2026-08-12 の tick 162 は、「破れた辺の双対像は偶部分グラフ」を四層すべてで完了した。
Lean 具体版は双対頂点の局所端点数を格子面境界の四破れ指示子の和へ展開し、
各辺の符号を両端スピンの積に移して四符号の積が $1$ であることを示し、
必要十分版 `four_signs_even_necSuf` を適用した。導出と sorry 非依存検査への登録も完了した。
次は、破れた辺の双対像の二つの巻き付き偶奇がどちらも $0$ であることを示す。

2026-08-12 の tick 161 は、「破れた辺の双対像は偶部分グラフ」の Lean 配線を途中まで進めた。
具体側に破れた辺集合の双対像と双対辺写像の二つの座標作用を置き、必要十分側では四つの破れ
指示子に対応する符号積が $1$ なら破れ数が偶数である核を全場合分けで証明した。局所端点数を
四指示子の和へ移す具体版と導出は未了なので、セクションは todo のままである。レビューでは
本文の双対像の指示関数の置換に欠けていた全単射性の参照を補い、前進前に独立して反映した。

2026-08-12 の tick 161 のレビューでは、前 tick の「破れた辺の双対像は偶部分グラフである」で、
双対像の指示関数を元の破れ指示関数へ置き換える等式が双対辺写像の全単射性を使っているのに、
その参照が欠けていたため、本文と式の根拠へ全単射性のラベル参照を追加した。

2026-08-12 の tick 160 は、前 tick の双対辺写像の全単射性を四層で突き合わせ、本文で省略されていた
反対向きの往復を、横向き辺・縦向き辺それぞれについて定義の代入を含む三段の鎖へ直し、独立に
`origin/main` へ反映した。そのあと「破れた辺の双対像は偶部分グラフ」を記述と SageMath まで進めた。
一つの格子面の四辺では各頂点のスピンが二度ずつ積に現れるため、破れた辺の本数が偶数になる。
Lean 具体版・必要十分版・導出は未着手で、次 tick はこの三本を完成させる。式変形統一では姉妹側の
「$T_{(V')}$ の $\psi$ への作用」の Step 4 を整え、この証明ブロックを完了した。

2026-08-12 の tick 159 は、巻き付き四セクターの Lean が本文より弱い命題だったため、
偶部分グラフであることと二つの巻き付き偶奇を含む所属定義へ直して独立に反映した。
そのあと、正方格子の各辺を交差する双対辺へ送る写像を定義し、明示した逆写像との二つの往復律から
全単射性を四層すべてで完了した。式変形統一では姉妹側の「$T_{(V')}$ の $\psi$ への作用」の
Step 3 を整えた。次は配位の破れた辺集合の双対像が偶部分グラフであることを示す。

2026-08-12 の tick 158 は、前 tick の高温展開四層を突き合わせて修正不要と確認し、
「偶部分グラフは四つの巻き付きセクターへ一意に分かれる」を四層すべてで完了した。
横・縦の周期境界をまたぐ辺の個数の偶奇を定義し、各偶部分グラフの唯一のセクターをその二値の組で
与えた。次は双対辺写像を定義し、配位の破れた辺集合の像が双対格子の自明なセクターに属することを
示す。式変形統一では姉妹側の「$T_{(V')}$ の $\psi$ への作用」の Step 2 を整えた。

2026-08-12 の tick 157 は、「高温展開の多項式恒等式」を四層すべてで完了した。レビューでは
二項展開と有限和の順序交換を別の等号へ分け、共通因子の消去も根拠つきの式として明示し、
前進前に独立して `origin/main` へ反映した。Lean 具体版は同じ有限和の二計算を人手証明と同じ順で
持ち、必要十分版は可換整域上の二評価と非零因子消去だけを残し、導出で $\mathbb{Z}[x]$ へ戻す。
式変形統一では姉妹側の「$T_{(V')}$ の $\psi$ への作用」の Step 1 を整えた。次は周期トーラスの
四つの境界セクターと Kramers--Wannier 双対である。

2026-08-12 の tick 156 は、「高温展開の多項式恒等式」を記述と SageMath まで進めた。
高温展開の整数多項式 $H_L$ を置き、一辺の二項表示を全辺へ掛けた計算と、辺部分集合ごとに
展開して偶部分グラフのスピン単項式和を適用する計算を突き合わせ、$2^{L^2}Z_L=H_L$ を得た。
SageMath は $L=1,2$ の全配位と全辺部分集合を `ZZ[x]` で厳密検査した。Lean 具体版・必要十分版・
導出は未着手なので、セクションは `todo` のままである。レビューでは tick 155 の四層を突き合わせ、
修正は無かった。式変形統一では姉妹側の「$T_{(V')}$ の $\psi$ への作用」の証明冒頭を整えた。

2026-08-12 の tick 155 は、「偶部分グラフとスピン単項式の和」を四層すべてで完了した。
レビューでは、非偶部分グラフ側で定義の否定から奇次数を取る橋渡しを自然数の偶奇として明示し、
前進前に独立して `origin/main` へ反映した。人手証明と Lean 具体版は、辺ごとの積を頂点ごとの冪へ
並べ替え、配位和を頂点ごとの二値和の積へ分配する同じ鎖を持つ。必要十分版
`sum_product_piecewise_even_necSuf` は有限な添字型と可換半環、および局所和の偶奇による二択値だけを
要求し、導出 `evenSubgraph_spinSum_from_necSuf` で正方格子へ戻す。次は「高温展開の多項式恒等式」。
並列の式変形統一では、姉妹側の「$\lambda_{\pm,\mu}=e^{\pm\gamma(\theta_\mu)}$」を整えた。

2026-08-12 の tick 154 は、「偶部分グラフと高温展開」を二つの独立した論法へ分割し、
先頭の「偶部分グラフとスピン単項式の和」を記述と SageMath まで進めた。辺の端点を番号つきで
数える次数、偶部分グラフ、生成多項式、スピン単項式の和をそれぞれ定義し、奇次数の頂点だけを
反転する配位の対による相殺から、全配位和が偶部分グラフで $2^{L^2}$、それ以外で零になることを
示した。Lean 具体版・必要十分版・導出は未着手であり、次 tick はこの三本を完成させる。

2026-08-12 の tick 154 のレビューでは、低温展開の多項式恒等式を四層で突き合わせた。
恒等式の対応に食い違いは無かったが、一つの定義ブロックに三定義が同居していたため、
配位の破れた辺集合・実現できる集合族・その生成多項式の三ブロックへ分け、
各ラベル参照と Lean 対応を個別に付け直した。

2026-08-12 の tick 153 は、前 tick の破れた辺集合の二つの原像を四層で突き合わせて
修正不要と確認した。そのうえで、実現できる破れた辺集合の生成多項式 $D_L$ を定義し、
各原像が互いに異なる全スピン反転の対なので $Z_L=2D_L$ となることを四層すべてで完了した。
SageMath は $L=1,2,3$ の全配位を厳密検査し、Lean は具体版・可換加法モノイドまで薄めた
必要十分版・その特殊化を持つ。次は偶部分グラフ生成多項式による高温展開である。
並列の式変形統一では、姉妹側の「$\det A(\theta_\mu)=1$」の Step 6 を整え、この証明を完了した。

2026-08-12 の tick 152 は、前 tick の全スピン反転による各辺の破れの不変性を四層で
突き合わせて修正不要と確認した。そのうえで、同じ破れた辺の集合を与える二つの配位は
互いに等しいか全スピン反転で結ばれることを四層すべてで完了した。辺の両端で二配位の
一致が同値であることを、横・縦の辺をたどる二つの帰納法で全頂点へ伝播した。
次は破れた辺の集合の生成多項式を定義し、分配多項式がその 2 倍であることを示す。
並列の式変形統一では、姉妹側の「$\det A(\theta_\mu)=1$」の Step 5 を整えた。

2026-08-12 の tick 151 は、前 tick の Fisher 零点の代数性を四層で突き合わせて修正不要と確認した。
Kramers--Wannier 双対を、高温展開・低温展開・周期トーラスの境界セクター処理を混ぜない形へ
分割し、先頭の「全スピン反転は各辺の破れを保つ」を四層すべてで完了した。全スピン反転を
$\nu_L(\sigma)(v):=-\sigma(v)$ と定義し、整数の加法逆元を取る写像の単射性だけで各辺の破れが
反転前後で一致することを示した。SageMath は $L=1,2,3,4$ の全配位・全辺を厳密検査した。
次は、同じ破れた辺の集合を与える二つの配位が全スピン反転だけで結ばれることを示す。
並列の式変形統一では、姉妹側の「$\det A(\theta_\mu)=1$」の Step 4 を整えた。

2026-08-12 の tick 150 は、前 tick の固有空間分解を四層で突き合わせて修正不要と確認した。
旧「Fisher 零点の代数性と Kramers--Wannier 双対」を独立した二論法へ分け、先頭の
「有限格子の Fisher 零点は代数的である」を四層すべてで完了した。整係数多項式の
代数的数における評価と Fisher 零点集合を定義し、$Z_L(1)=2^{L^2}\ne0$ から $Z_L\ne0$ を示して、
各 Fisher 零点が非零な整係数多項式 $Z_L$ の根であることを証拠つきで述べた。
SageMath は $L=1,2,3$ の実在する 20 個の根を `QQbar` で厳密計算した（$L=1$ では $Z_1=2$ で
根は無い）。次は Kramers--Wannier 双対である。並列の式変形統一では、姉妹側の
「$\det A(\theta_\mu)=1$」の Step 3 を一続きの鎖へ整えた。

2026-08-12 の tick 149 は、前 tick の復元式を四層で突き合わせ、Lean 3 定理の sorry 依存検査への
登録漏れを修正した。そのうえで「シフト行列の固有空間たちは列ベクトルの全体を張る」を四層すべてで
完了した。各 $z\in\mu_L$ に $u_z=L^{-1}P_{A,z}(v)$ を割り当て、像の所属・固有空間のスカラー倍への
閉性・復元式を組み合わせた。次は Fisher 零点の代数性と Kramers--Wannier 双対である。並列の
式変形統一では、姉妹側の「$\det A(\theta_\mu)=1$」の Step 2 を一続きの鎖へ整えた。

2026-08-12 の tick 148 は、tick 147 の「1 の冪根の全体にわたる冪の和の値」を四層で
突き合わせて修正不要と確認し、「固有空間へ落とす写像から列ベクトルを復元できること」を
四層すべてで完了した。根と冪の二重有限和を入れ替え、根にわたる冪の和で $k=0$ の項だけを
残して $A^0v=v$ へ戻す。必要十分版は一般の体上の有限線形結合の復元まで薄め、具体版と
必要十分版からの導出を分離した。検証は構造化テキスト 275 ラベル、SageMath 対応 129 件、
sorry 検査 699 件、PDF 141 ページですべて通過した。次は、各加数が対応する固有空間へ入ることと
復元式を組み合わせ、シフト行列の固有空間たちが列ベクトル全体を張ると結論する段である。
並列の式変形統一では、姉妹側の「$\det A(\theta_\mu)=1$」の Step 1 を一続きの鎖へ整えた。

2026-08-12 の tick 147 は、tick 146 の「指数が根の次数の倍数でないとき、冪が 1 でない
1 の冪根が存在する」を四層で突き合わせて修正不要と確認し、「1 の $n$ 乗根の全体にわたる
冪の和の値」を四層すべてで完了した。$n\mid m$ なら既存の倍数の場合の値を当て、$n\nmid m$
なら冪が 1 でない根の存在と冪和の零性を組み合わせた。必要十分版は命題の成立側・不成立側の
値だけを要求し、値の型に代数構造を要求しない。SageMath は 144 組を `QQbar` で厳密計算した。
検証は構造化テキスト 274 ラベル、SageMath 対応 128 件、sorry 検査 699 件、PDF 141 ページで
すべて通過した。
次は「シフト行列の固有空間たちが列ベクトルの全体を張ること」の組み立てである。並列の
式変形統一では、姉妹側の「$\psi$ の反交換関係」の c) を一続きの式変形と行末根拠へ整え、
同証明の Step 0 と a)〜c) の統一を完了した。

2026-08-12 の tick 146 は、tick 145 の「指数が根の次数の倍数のときの冪の和の値」を四層で
突き合わせて修正不要と確認し、「$n$ が $m$ を割らないとき $w^{m}\ne1$ を満たす $w\in\mu_n$ が
存在すること」を四層すべてで完了した。台帳の見込みの論法（$\mu_m$ との個数の比較）は
$n\le m$ しか出ないため、除法 $m=nq+r$（$1\le r<n$）による背理法へ変えた。すべての元の
$m$ 乗が 1 なら鎖で $r$ 乗も 1 となり $\mu_n\subseteq\mu_r$、個数 $n$ と指数 $r$ の部分集合
上界から $n\le r<n$ の矛盾が出る。必要十分版は単位元・積・冪の記号と鎖の 4 法則・除法の分解・
境界 1 仮定だけを要求する（$1\le r$ も割り切らないことも有限性も不要）。検証は構造化テキスト
273 ラベル、SageMath 対応 127 件、sorry 検査 696 件、PDF 140 ページですべて通過した。
次は c4c4（冪の和の値の確定。c4c1〜c4c3 の組み立て）である。並列の式変形統一では、姉妹側の
「$\psi$ の反交換関係」の b) を一続きの式変形と行末根拠へ整えた。

2026-08-12 の tick 145 は、前 tick の異常終了で残った「指数が根の次数の倍数のとき、冪の和は
根の次数の与える代数的数である」を回収し、四層すべてで完了した。本文は各項を 1 にし、
$\mu_n$ と番号の集合の全単射で添字を取り替え、$\lvert\mu_n\rvert=n$ と単位元の有限和の値を
当てる鎖である。レビューで Lean の import と定理名の誤りを直した。必要十分版は可換加法
モノイド上で、各項の定数値・添字型の元の個数・番号の集合にわたる有限和の値だけを要求する。
検証は構造化テキスト 272 ラベル、SageMath 対応 126 件、sorry 検査 693 件、PDF 140 ページで
すべて通過した。次は、$n$ が $m$ を割らないとき $w^m\ne1$ を満たす $w\in\mu_n$ の存在である。
並列の式変形統一では、姉妹側の「$\psi$ の反交換関係」の a) を一続きの式変形と行末根拠へ整えた。
次は同じ証明の b) から続ける。

2026-08-12 の tick 144 は、前 tick の「冪が 1 でない根がある場合の冪の和の零性」を四層で
突き合わせて修正不要と確認し、「指数が $n$ の倍数のときの冪の和の値」を二論法へ分け、先頭の
「指数が根の次数の倍数ならば 1 の冪根の冪は 1 である」を四層すべてで完了した。
本文は $w^m=w^{nk}=(w^n)^k=1^k=1$ の鎖で、必要十分版は単位元と自然数冪の記号、および
鎖の 3 等式だけを要求する。検証は構造化テキスト 271 ラベル、SageMath 対応 125 件、
sorry 検査 689 件、PDF 139 ページですべて通過した。次は、$\mu_n$ にわたる単位元の有限和を
$\lvert\mu_n\rvert=n$ が与える代数的数へ数え替える段である。並列の式変形統一では、姉妹側の
「$\psi$ の反交換関係」の Step 0（平方根の分枝一致）を一続きの式変形と行末根拠へ整えた。

2026-08-12 の tick 143 は、tick 142 の「1 の $n$ 乗根の個数」を四層で突き合わせて修正不要と
確認し、「1 の $L$ 乗根の全体にわたる冪の和の値」を論法の数で 4 つへ割り直したうえで、先頭の
「冪が 1 でない 1 の冪根があるとき、冪の和は零元である」（$n\ge1$、$w\in\mu_n$、$w^{m}\ne1$
ならば $S_{n,m}=0$）を四層すべてで完了した。本文は準備 2 つ（$\mu_n$ の有限性・$w^{m}-1\ne0$）と
4 段の鎖 $(w^{m}-1)S=0$ に零因子の不在を当てる 1 本で、必要十分版は「$a$ 倍で動かない元は
$a-1$ が左可逆なら零元」という環の上の 1 本の言明まで薄めた（和の構造・冪・体・可換性は不要）。
検証は構造化テキスト 270 ラベル、SageMath 対応 124 件、sorry 検査 686 件、PDF 139 ページで
すべて通過した。次は「指数が $n$ の倍数のときの冪の和の値」である。並列の式変形統一では、姉妹側の主張「$V$ と $\psi$ の交換関係」の鎖 9 段すべてへ行末の根拠を付けた（次は「$\psi$ の反交換関係」）。

2026-08-12 の tick 142 は、tick 141 の分解の帰納法本体の Lean 3 本を本文と突き合わせて
修正不要と確認し、「1 の $n$ 乗根の全体はちょうど $n$ 個の元を持つ」を四層すべてで完了した。
本文と Lean 具体版は、既存の上界 $\lvert\mu_n\rvert\le n$ と、分解の帰納法を $j=n$ に
当てて得る相異なる $n$ 個の元を組み合わせる。必要十分版は有限集合・上界・相異なる $n$ 個の元だけを
要求し、元の型に代数構造を要求しない。検証は構造化テキスト 269 ラベル、SageMath 対応 123 件、
sorry 検査 683 件、PDF 138 ページですべて通過した。並列の式変形統一では、姉妹側の主張
「$a(\theta_\mu)$」の Steps 17–18 を一続きの鎖へ整え、同主張の Steps 1–18 の統一を完了した。
次は「1 の $L$ 乗根の全体にわたる冪の和の値」である。

2026-08-12 の tick 141 は、tick 140 の r4 を本文・SageMath で突き合わせて修正不要と確認し、
d4b2dL「分解を構成する帰納法本体の Lean 具体版・必要十分版・導出」を完了した。これで
d4b2d（$j\le n$ について相異なる $j$ 個の根の一次因子の積と係数上界 $n-j$・先頭係数 1 の商への
分解の存在）が四層すべてを満たした。具体版は本文と同じ帰納法で、準備 4 補題（出発点の係数上界・
代数閉性による根の存在・因数定理の商の 3 条件・一次因子の根の $\mu_n$ への所属）を本文の準備の段と
対応させた。必要十分版は可換モノイドの上で、根の供給・因数分解・所属・取り出し・積の上界・単調性・
相異性を抽象的な仮定として受け取り、同じ帰納法を通す（代数閉性は仮定の供給側に隔離される）。
検証は構造化テキスト 268 ラベル、SageMath 対応 122 件、sorry 検査 680 件、PDF 138 ページで
すべて通過した。次は d5（$\mu_n$ がちょうど $n$ 個の元を持つこと。d2 の上界と d4 の下界の組み立て）である。

2026-08-12 の tick 140 は、tick 139 の r3 を全層で突き合わせて修正不要と確認し、
r4「帰納法本体の欠陥段の書き直し」を完了した。取り出した残りの因子 $B$ の係数上界 $j-1$ と
商 $g$ の係数上界 $n-j$ へ積の係数上界を当て、$h=Bg$ の係数が $n-1$ より上で零になることを
既存の主張の適用だけで導いた。これで根の相異性の主張に必要な $k>n$ での係数の零性が埋まった。
SageMath も各帰納段・各既出根について $B$ の構成と上界、$h=Bg$、積の上界、根の相異性を
検査する形へ更新した。検証は構造化テキスト 268 ラベル、SageMath 対応 122 件、sorry 検査 673 件、
PDF 138 ページですべて通過した。次は d4b2dL（同じ帰納法本体の Lean 具体版・必要十分版・導出）である。

2026-08-12 の tick 139 は、tick 138 の r2 を四層すべて突き合わせて修正不要と確認し、
r3「因子の取り出しの強化」を完了した。「一次因子の積から指定した一つの因子を先頭へ取り出せる」
（`claim_qbar_poly_linear_factor_product_extract`）の statement へ、取り出した残りの因子 $B$ が
係数上界 $j-1$ つきに取れることを加え、証明・SageMath・Lean 具体版・必要十分版・導出を更新した。
場合 $i=j$ の上界は r2、場合 $i\ne j$ の上界は可換則と d4b2a で出る。必要十分版は可換モノイドと
抽象的な上界の述語 2 仮定（有限積そのものの上界・因子を掛けると上界が 1 つ上がること）だけを
要求する。検証は構造化テキスト 268 ラベル、SageMath 対応 122 件、sorry 検査 673 件、
PDF 137 ページですべて通過した。次は r4（帰納法本体 d4b2d の欠陥段の書き直し。$B$ の上界と
r1 の積の係数上界で $k>n$ における $\mathrm{ac}_k(h)=0$ を主張の適用として出す）である。

2026-08-12 の tick 138 は、tick 137 の積の係数上界を四層すべて突き合わせて修正不要と確認し、
r2「一次因子の積の係数は、因子の個数より上の番号で零である」を四層すべてで完了した。
主張は `claim_qbar_poly_linear_factor_product_coeff_bound`、SageMath は
`qbar-poly-linear-factor-product-coeff-bound`、Lean は具体版・必要十分版・導出を持つ。
論法は因子の個数についての帰納法 1 本（空積から出発し、最後の因子を可換則で先頭へ移して
一次因子との積の係数上界を当てる）である。検証は構造化テキスト 268 ラベル、SageMath 対応 122 件、
sorry 検査 673 件、PDF 137 ページですべて通過した。次は r3（因子の取り出しの強化）である。

2026-08-12 の tick 137 のレビューで、tick 136 の分解の帰納法本体（d4b2d）の根の相異性の段に、
既存の主張の適用では出ない箇所を見つけた。「$B$ は $j-1$ 個の一次因子の積であるから」は
引いた主張（存在と等式のみ）から従わず、「各因子へ順に当てる」は形式化できない反復であり、
その結果 $h=Bg$ の係数上界 $k>n\Rightarrow\mathrm{ac}_k(h)=0$ が導出できない。修復を
r1（積の係数上界）・r2（一次因子の積の係数上界）・r3（因子の取り出しの強化。tick 134 の
Lean 更新を含む）・r4（d4b2d の欠陥段の書き直し）へ割り、d4b2dL の前へ積んだ。
同 tick で r1「係数上界つき多項式の積の係数は、上界の和より上の番号で零である」を四層すべてで
完了した（主張 `claim_qbar_poly_product_coeff_bound`、SageMath `qbar-poly-product-coeff-bound`、
Lean 具体版・必要十分版・導出。必要十分版は**半環で足りる**——引き算が一度も出ない）。
検証は構造化テキスト 267 ラベル、SageMath 対応 121 件、sorry 検査 670 件、PDF 136 ページで
すべて通過した。次は r2（一次因子の積の係数の上界。$m$ についての帰納法 1 本）である。

2026-08-12 の tick 136 で、根の多項式 $f=t^{\,n}+\widehat{-1}$ から相異なる根の一次因子を
順に取り出す帰納法本体を**記述と SageMath まで**進めた。$j\le n$ について、相異なる $j$ 個の
根・一次因子の積と商の分解・商の係数上界 $n-j$・先頭係数 1 を同時に保つ。
SageMath は $1\le n\le6$ と全段 $0\le j\le n$ で分解・係数・根の所属・相異性を厳密計算した。
検証は構造化テキスト 266 ラベル、SageMath 対応 120 件、PDF 136 ページ、既存 Lean の build が通過した。
レビューでは tick 135 の根の相異性を四層で突き合わせ、修正は無かった。
並列の式変形統一では、姉妹側の主張「$a(\theta_\mu)$」Part B、Steps 9–11 を 3 段の鎖へ整えた。
**Lean 具体版・必要十分版・導出は未着手**であり、次は同じ主張の Lean を完成させる。

2026-08-12 の tick 135 で、取り出した分解の残りの因子の根が取り出した因子の根と相異なること
（$n\ge1$、$w\in\mu_n$、$f=t^{\,n}+\widehat{-1}$、係数上界つきの $h$ で $f=(t-\widehat{w})h$、
$h=Ag$、$\mathrm{aev}_{w'}(g)=0$ ならば $w'\ne w$）を四層すべてで完了した。本文は背理法 1 本で、
$w'=w$ と仮定して $\mathrm{aev}_{w}(h)$ を 5 段の鎖で零へ落とし、前段（残りの因子の値の非零性）と
矛盾させる。必要十分版が要求するのは、分解の等式・その点での評価が「この積」を保つこと・
「この値」と零元の積が零元であること・終点の非零性だけで、代数構造は一切不要である。
検証は構造化テキスト 265 ラベル、SageMath 対応 119 件、Lean の sorry 検査 667 件、
PDF 134 ページですべて通過した。レビューでは tick 134 の因子の取り出しを四層で突き合わせ、
修正は無かった。次は d4b2d（分解を構成する帰納法本体）である。

2026-08-12 の tick 134 で、一次因子の積から指定した一つの因子を先頭へ取り出せることを
四層すべてで完了した。本文と Lean 具体版は因子の個数についての帰納法で、指定した因子が
最後なら可換則、それより前なら帰納法の仮定と結合則を使う。必要十分版が要求するのは
可換モノイドだけである。レビューでは tick 133 の残りの因子の値の非零性を四層で突き合わせ、
修正は無かった。並列の式変形統一では、姉妹側の主張「$a(\theta_\mu)$」Part A、Step 6 を
一ステップ一根拠へ整えた。次は、新しく取った根が既出の根と相異なることの背理法本体である。

2026-08-12 の tick 133 で、旧セクション「取った根が既出の根と相異なること」を 3 つの論法
（残りの因子の値の非零性・積からの因子の取り出し・背理法本体）へ割り直し、先頭の
「一次因子との分解の残りの因子の、その一次因子の根における値は零でない」
（$w\in\mu_n$、$f=t^{\,n}+\widehat{-1}$、係数上界つきの $B$ について
$f=(t-\widehat{w})B$ ならば $\mathrm{aev}_{w}(B)\ne0$）を四層すべてで完了した。
本文は因数定理・一次因子の消去・商の値の非零性を組み立てる適用の鎖 1 本で、
必要十分版は 2 つの分解の等式・左因子の消去・値の書き換えだけを仮定する
（型に代数構造は一切不要）。検証は構造化テキスト 263 ラベル、SageMath 対応 117 件、
Lean の sorry 検査 661 件、PDF 133 ページですべて通過した。
レビューでは tick 132 の先頭係数の維持を四層で突き合わせ、修正は無かった。
次は一次因子の積から 1 つの因子を先頭へ取り出せること（並べ替えの帰納法）である。

2026-08-12 の tick 132 で、一次因子との積の先頭の係数がもとの先頭の係数に等しいことを
四層すべてで完了した。本文と SageMath は積の係数を開いて上の番号の係数を零にする 4 段、
Lean 具体版も同じ手順である。必要十分版に必要なのは可換環だけで、体・代数閉性は不要である。
次は、分解で新しく取った根が既出の根と相異なることを示す。

レビューでは tick 131 の係数上界を四層で突き合わせ、修正は無かった。

2026-08-12 の tick 131 で、根の個数の下界の帰納法本体（旧 d4b2）を 4 つの論法
（一次因子との積の係数の上界・先頭の係数の維持・取った根が既出の根と相異なること・
分解を構成する帰納法本体）へ割り直し、先頭の「一次因子との積の係数は、上の番号で零である」
（$k>m$ で $\mathrm{ac}_k(C)=0$ ならば $k>m+1$ で $\mathrm{ac}_k((t-\widehat{w})C)=0$）を
四層すべてで完了した。準備（$i\ge2$ の一次式の係数が零。3 段）と本体（積の係数を開いて
全項を消す 6 段）の鎖 1 本で、必要十分版は任意の可換環で通る（体・代数閉性は不要）。
レビューでは tick 130 の Lean 3 ファイルを本文と突き合わせ、修正は無かった。
検証は構造化テキスト 261 ラベル、SageMath 対応 115 件、Lean の sorry 検査 655 件、
PDF 132 ページですべて通過した。次は先頭の係数の維持
（$\mathrm{ac}_{m+1}((t-\widehat{w})C)=\mathrm{ac}_m(C)$。d4b2b）である。

2026-08-12 の tick 130 で、「一次因子は消去できる」の Lean 具体版・必要十分版・導出を完成させ、
四層すべてを満たした。具体版は本文と同じ $P(j)$ の帰納法で上の番号から下へ係数を復元し、
必要十分版は同じ論法が任意の可換環で通ることを示した（体・代数閉性は不要）。
レビューでは tick 129 の本文と SageMath の各段を突き合わせ、修正は無かった。
検証は構造化テキスト 260 ラベル、SageMath 対応 114 件、Lean の sorry 検査 652 件、
PDF 131 ページですべて通過した。並列の式変形統一では、姉妹プロジェクトの同じ主張に残る
固有ベクトルの行基本変形以降 9 段へ行ごとの根拠を付けた。
次は根の個数の下界の帰納法本体である（着手時に論法の数で割り直す）。

2026-08-12 の tick 129 で、下界の帰納法の一歩（旧 d4b）を「一次因子の消去」と「帰納法本体」の
2 つへ割り、先頭の「一次因子は消去できる」（$(t-\widehat{w})A=(t-\widehat{w})B$ ならば $A=B$）を
**記述と SageMath まで**進めた。準備で一次式の係数と一次因子との積の係数
$\mathrm{ac}_{m+1}((t-\widehat{w})C)=\mathrm{ac}_m(C)+(-w)\,\mathrm{ac}_{m+1}(C)$ を計算し、
本体は「$k+j\ge n+1$ なる番号 $k$ で係数が一致する」という言明の $j$ についての帰納法 1 本である。
これは因数定理の商の一意性（帰納法本体で「取った根が商の根でない」を単根性から出す段）の道具である。
検証は構造化テキスト 260 ラベル、SageMath 対応 114 件、Lean の sorry 検査 649 件、
PDF 131 ページですべて通過した。**Lean は未着手**で、実行の列の先頭（10h3d-c4b-d4b1L）に積んである。
レビューでは tick 128 完了分が本文末尾の済み一覧に追記されていなかった食い違いを直した。
並列の式変形統一では、姉妹プロジェクトの「$A(\theta_\mu)$ の固有値と固有ベクトル」の
二次方程式の解の公式の 4 行を 6 段の鎖へ開いた。次は同じ主張の固有ベクトルの計算
（行基本変形以降）である。

2026-08-12 の tick 128 で、根の個数の下界の帰納法を出発点と一歩へ分け、出発点
「$\mu_1=\{1\}$」を四層すべてで完了した。本文は集合の等号を両包含で示し、各向きで
1 乗の値を 2 段の鎖として確かめた。必要十分版は集合への所属が指定した元との相等に一致すること
だけを要求し、型に代数構造を要求しない。検証は構造化テキスト 259 ラベル、SageMath 対応 113 件、
Lean の sorry 検査 649 件、PDF 130 ページですべて通過した。次は帰納法の一歩
（根を 1 つ取り一次因子を除き、単根性により残りの根と相異なることを保つ段）である。
並列の式変形統一では、姉妹プロジェクトの「$A(\theta_\mu)$ の固有値と固有ベクトル」の
固有方程式の左辺を 4 段の鎖へ整えた。次は同じ証明の二次方程式の解の公式の鎖である。

2026-08-12 の tick 127 で、「因数定理の商の、もとの根における値は零でない」
（単根性の核 $\mathrm{aev}_{w}(g)\ne0$）を四層すべてで完了した。準備で 3 つの非零性
（$w\ne0$・$w^{n-1}\ne0$・零でない元を正の個数だけ足した有限和の非零性）を立て、
$\mathrm{aev}_{w}(g)$ を $g=K_n(w)$ と商の値の計算の 2 段の等式で有限和へ書き換えて
終点の非零性を当てる組み立ての鎖である。必要十分版は「2 段の等式の鎖の始点は、終点が
指定した元と異なるならその元と異なる」まで薄め、型に代数構造が一切不要であることを示した。
検証は構造化テキスト 258 ラベル、SageMath 対応 112 件、Lean の sorry 検査 646 件、
PDF 130 ページですべて通過した。これで旧 d3（単根性）の分割がすべて済んだ。
次は 10h3d-c4b-d4（$t^{\,n}+\widehat{-1}$ が $n$ 個の相異なる根を持つこと。
着手時に論法の数で割り直す）である。

2026-08-12 の tick 126 で、旧セクション「因数定理の商と冪の差の商の一致、および商の値の非零性」を
独立の 2 つの論法へ分け、先頭の「$f=t^n+\widehat{-1}$ に対する因数定理の商 $g$ は
$K_n(w)$ に等しい」を四層すべてで完了した。係数の有限和の番号 $n$ の項だけが残る
4 段の鎖で、必要十分版は「指定した 1 項が求める値で、他の項は零」という仮定だけを要求する。
検証は構造化テキスト 257 ラベル、SageMath 対応 111 件、Lean の sorry 検査 643 件で通過した。
次は、$g=K_n(w)$、$w\ne0$、冪の非零性、正の個数の有限和の非零性を組み立てて
$\mathrm{aev}_{w}(g)\ne0$ を得る。

2026-08-12 の tick 125 で、「零でない代数的数を正の個数だけ足した有限和は零でない」を
四層すべてで完了した。和を単位元の有限和との積へ分解し
（`claim_qbar_repeated_sum_factorization`）、単位元の和の非零性
（`claim_qbar_unit_sum_ne_zero`）と零因子の消去（`claim_qbar_no_zero_divisors`）を当てる
適用の鎖 1 本（背理法）である。必要十分版は分解・非零性・消去の 3 仮定だけを要求する
（和や積の法則そのものも体も代数閉性も不要）。検証は構造化テキスト 256 ラベル、
SageMath 対応 110 件、Lean の sorry 検査 640 件、PDF 129 ページですべて通過した。
これで旧 d3d（零でない代数的数の $n$ 個の和の非零性）の 3 分割がすべて済んだ。
次は 10h3d-c4b-d3e（因数定理の商 $g$ が $K_n(w)$ に等しいことと単根性の核
$\mathrm{aev}_{w}(g)\ne0$。着手時に論法の数で割り直す）である。

2026-08-12 の tick 124 で、「単位元を正の個数だけ足した有限和は零でない」を四層すべてで
完了した。前段の等式 $\sum_{i<n}1=n$ から、和が零ならば $n=0$ となって $n\ge1$ と矛盾する
適用の鎖 1 本である。Lean 具体版は $\mathbb{Q}$ から $\overline{\mathbb{Q}}$ への埋め込みが
非零性を保つことを明示し、必要十分版は有限和と自然数の像の等式、および正の自然数の像が
零でないことだけを要求する。検証は構造化テキスト 255 ラベル、SageMath 対応 109 件、
Lean の sorry 検査 637 件、PDF 128 ページですべて通過した。次は
「零でない代数的数の正の個数の和は零でないこと」の組み立てである。

2026-08-12 の tick 123 で、旧セクション「単位元の $n$ 個（$n\ge1$）の有限和は零でないこと」を
論法の数で 2 つ（等式の帰納法・非零性の適用の鎖）へ割り直し、最初の
「単位元の有限和は、自然数の与える有理数に等しい」（$\sum_{i<n}1=n$、$n$ についての帰納法 1 本）を
四層すべてで完了した。本文は部分集合の鎖 $\mathbb{N}\subset\mathbb{Z}\subset\mathbb{Q}$ と
$\mathbb{Q}\subset\overline{\mathbb{Q}}$（部分体）で書き、同一視の写像を持ち込まない。
Lean 具体版はこの鎖を `Nat.cast` と `algebraMap ℚ Qbar` の合成で書き、必要十分版は
有限和の空和と再帰、および自然数を値の側へ送る写像の 2 つの再帰式だけを要求する
（等式は「両辺が同じ再帰を満たすこと」そのもので、加法の性質も積も体も不要）。
検証は構造化テキスト 254 ラベル、SageMath 対応 108 件、Lean の sorry 検査 634 件、
PDF 128 ページですべて通過した。次は「単位元の $n\ge1$ 個の有限和は零でないこと」
（10h3d-c4b-d3d2b。適用の鎖 1 本）である。

2026-08-11 の tick 122 で、「同じ元の有限和は、単位元の有限和との積である」の
Lean 具体版・必要十分版・導出を完成させ、四層すべてを満たした。具体版は本文と同じ帰納法で、
必要十分版は有限和の空和と再帰、零元の左吸収、単位元の左作用、右分配則だけを要求する。
検証は `lake build` と sorry 検査 631 件を含めて全通過した。次は
「単位元の $n$ 個（$n\ge1$）の有限和は零でないこと」である。

2026-08-11 の tick 121 で、旧セクション「零でない代数的数の $n$ 個の和は零でない」を
論法の数で 3 つ（同じ元の有限和の分解・単位元の有限和の非零性・組み立て）へ割り直し、
最初の「同じ元の有限和は、単位元の有限和との積である」
（$\sum_{i<n}a=(\sum_{i<n}1)\cdot a$、$n$ についての帰納法 1 本）を
**記述と SageMath まで**進めた。スカラー倍や自然数倍の新記法は持ち込んでいない。
検証は構造化テキスト 253 ラベル、SageMath 対応 107 件、Lean の sorry 検査 628 件、
PDF 127 ページですべて通過した。**Lean は未着手**で、実行の列の先頭
（10h3d-c4b-d3d1L）に積んである。

2026-08-11 の tick 120 で、「零でない代数的数の冪は零でない」を四層すべてで完了した。
$n$ についての帰納法 1 本で、出発点は $w^0=1\ne0$、一歩は $w^kw=w^{k+1}=0$ と
`claim_qbar_no_zero_divisors` から $w=0$ を導く背理法である。必要十分版は冪の零乗が非零・
冪の再帰・零でない左因子の消去だけを仮定する。検証は構造化テキスト 252 ラベル、
SageMath 対応 106 件、Lean の sorry 検査 628 件、PDF 127 ページですべて通過した。
次は「零でない代数的数の同じ元の有限和は零でないこと」である。

2026-08-11 の tick 119 で、「1 の冪根は零でない」（$n\ge1$、$w\in\mu_n$ ならば $w\ne0$）を
四層すべてで完了した。背理法 1 本（鎖 $1=w^{\,n}=0^{\,n}=0^{\,(n-1)+1}=0^{\,n-1}\cdot0=0$ が
体の $1\ne0$ と矛盾）で、$0^{\,n}=0$ は帰納法でなく冪の約束と積の零元の 1 段で出る。
必要十分版は代数構造を持たない型の上で、冪の再帰式・zero の右吸収・one≠zero の 3 つだけを
仮定して同じ鎖を通す（結合則・可換性・単位元であること・体・代数閉性は不要）。
検証は構造化テキスト 251 ラベル、SageMath 対応 105 件、Lean の sorry 検査 625 件、
PDF 126 ページですべて通過した。次は「零でない代数的数の冪は零でないこと」
（10h3d-c4b-d3c。帰納法で `claim_qbar_no_zero_divisors` を一歩に使う）である。

2026-08-11 の tick 118 で、「冪の差の因数分解の商の、もとの根における値」の
Lean 具体版・必要十分版・導出を完成させ、このセクションを四層すべてで完了した。
具体版は本文と同じ帰納法、必要十分版は 2 つの半環・商の再帰式・評価写像の保存則だけで同じ鎖を
通す。`lake build` と sorry 検査 622 件を含む検証一式は全通過した。
次は $n\ge1$ のとき $\mu_n$ の元が零でないことを示す段である。

2026-08-11 の tick 117 で、旧セクション「因数定理の商のもとの根における値が零でないこと」を
論法の数で 5 つ（値の計算・その Lean・$\mu_n$ の元が零でないこと・零でない元の冪・
標数 0 の和と組み立て）へ割り直し、最初の「冪の差の因数分解の商のもとの根における値」
（$\mathrm{aev}_{w}(K_n(w))=\sum_{i<n}w^{\,n-1}$、$n\ge1$ の帰納法 1 本）を
**記述と SageMath まで**進めた。値は「同じ項を $n$ 個足す有限和」として書き、スカラー倍の
新記法を持ち込まない。検証は構造化テキスト 250 ラベル、SageMath 対応 104 件、
Lean の sorry 検査 619 件、PDF 126 ページですべて通過した。**Lean は未着手**で、
実行の列の先頭（10h3d-c4b-d3aL）に積んである。

2026-08-11 の tick 116 で、$n\ge1$ のとき $\mu_n$ 自身が有限で $|\mu_n|\le n$ であることを
四層すべてで完了した。無限性から $n+1$ 個の有限部分集合を取って直前の上界と矛盾させる背理法で、
必要十分版は代数構造を一切要求しない。検証は構造化テキスト 249 ラベル、SageMath 対応 103 件、
Lean の sorry 検査 619 件、PDF 125 ページですべて通過した。

数はいずれも構造化テキストのラベルの数である（1 つのブロックが定義を 2 つ以上宣言している
箇所があるので、ブロックの数とは一致しない。実測値をここに書く）。
章「分配多項式」（定義 10 件・主張 3 件）、章「有限系の自由エントロピー」（定義 4 件・主張 5 件）、
章「転送行列」（定義 14 件・主張 6 件・定理 1 件。$Z_L=\operatorname{Tr}(T^L)$ まで）、
および章「固有値の代数性」（定義 44 件・主張 67 件・定理 2 件。行配位の辞書式順序・置換の符号・
行列式・もう 1 つの不定元 $t$ の多項式環と次数・特性多項式・行配位の巡回シフト・
シフト行列と転送行列の可換性・シフト行列の位数 $U^{L}=I$・行配位の最小周期・行配位の軌道・
軌道による行配位の全体の分割・特性多項式の消えない項の同定・軌道を保つ置換の軌道への制限・
軌道ごとの置換の組の貼り合わせ・2 つの軌道にまたがる転倒対の偶数性・転倒数の軌道ごとの分解・
行配位の空でない部分集合の最小元・またぐ転倒対の全体の個数の偶数性・
符号の軌道ごとの符号の積への分解・項の軌道ごとの因子への分解・$\chi_U$ の和の軌道を保つ置換への絞り込み・
和の添字の軌道ごとの置換の組への取り替え・
代数的数の全体 $\overline{\mathbb{Q}}$ と 1 の冪根の全体 $\mu_n$・
$\mathbb{Z}[x][t]$ の元の代数的数における値 $\mathrm{ev}_{\xi,z}$ と、
軌道ごとの因子の値を 0 にする代数的数が 1 の冪根であること）が、
四層すべて（記述・SageMath・Lean 具体版・Lean 必要十分版）を満たした。

| 層 | 状態 |
| --- | --- |
| 記述（構造化テキスト） | ラベルの数は合計 246 件（定義・主張・定理・注意）。`npm run check` と `npm run build:pdf` が全通過 |
| SageMath 検証 | `partition-polynomial-coefficient-sum` / `partition-polynomial-coefficient-representation` / `free-entropy-definition` / `free-entropy-additivity` / `transfer-matrix-row-decomposition` / `transfer-matrix-trace-formula` / `transfer-matrix-power-entry` / `transfer-matrix-trace` / `row-config-order` / `permutation-sign` / `determinant` / `second-polynomial-degree` / `characteristic-polynomial` / `row-config-shift` / `shift-matrix` / `shift-matrix-order` / `row-shift-minimal-period` / `row-shift-orbit` / `row-shift-orbit-partition` / `shift-matrix-characteristic-term` / `orbit-restriction` / `orbit-gluing` / `cross-orbit-inversions` / `inversion-orbit-decomposition` / `row-config-min` / `oriented-orbit-pairs` / `orbit-permutation-sign` / `orbit-term-factorization` / `shift-char-sum` / `shift-char-family-sum` / `orbit-family-insert` / `orbit-family-distributive` / `shift-char-orbit-product` / `orbit-bijection-id-or-shift` / `orbit-permutation-sign-values` / `orbit-transposition` / `orbit-transposition-sign` / `orbit-transposition-composite` / `row-shift-iterate-distinct` / `orbit-transposition-composite-values` / `power-sum-telescope` / `orbit-sum-divides-pow-L` / `prod-pair-eq-pow-card` / `shift-char-dvd-pow-L` / `shift-char-orbit-factorization` / `root-of-unity-divisor` / `orbit-factor-root` / `second-evaluation-prod` / `qbar-prod-zero` / `qbar-action-product` / `qbar-action-linear` / `qbar-eigenspace` / `qbar-identity-action` / `qbar-action-pow` / `qbar-eigenvector-pow` / `qbar-matrix-eval` / `qbar-matrix-eval-identity` / `qbar-matrix-product-assoc` / `qbar-identity-matrix-unit` / `qbar-matrix-pow-succ-right` / `qbar-matrix-eval-pow` / `qbar-smul-eq-zero` / `shift-matrix-eigenvalue-root-of-unity` / `qbar-commuting-eigenspace` / `qbar-shift-transfer-commute` / `qbar-transfer-preserves-shift-eigenspace` / `qbar-action-sum` / `qbar-smul-sum` / `qbar-projector-action` / `qbar-projector-image-eigenspace` / `qbar-mul-pow` / `root-of-unity-mul` / `root-of-unity-pow` / `root-of-unity-mul-map` / `root-of-unity-power-sum-invariant` / `qbar-geometric-telescope` / `qbar-no-zero-divisors` / `root-of-unity-geometric-sum-zero` / `qbar-power-difference-factorization` / `qbar-poly-power-difference-factorization` / `qbar-poly-indeterminate-power-coefficient` / `qbar-poly-monomial-decomposition` / `qbar-const-embedding-pow` を実行済み（走らせた $L$ の範囲は検証ごとに違う。分配多項式まわりは $L=1,2,3$、巡回シフトとシフト行列は $L=1,2,3,4$、最小周期と軌道と分割は $L=1,\dots,6$。いずれも厳密計算。各 `overview.md` が正本） |
| Lean 具体版 | 上記の定義と主張と定理に対応する形式化（未着手の主張は無い）。`lake build` と `check-no-sorry.sh`（定理 610 件を登録）が通る |
| Lean 必要十分版 | 主張 113 件と定理 3 件について作成済み（うち 1 件（行列の積の結合則）は、既にある作用の側の必要十分版をそのまま特殊化したもので、新しい必要十分版を書き起こしていない。2026-08-11 の tick 79 で、本文の `lean` フィールド（ブロックに対応する Lean の定理名）を機械的に数え直した。本文の主張は 120 件（tick 106 時点）なので、必要十分版を置いていない主張は **9 件**である（前の記録の 16 件は、必要十分版が実在するのに本文へ名前が書かれていなかった 2 件と、tick 79 で新たに置いた 1 件を含んでいた）。置いていない 9 件は $\Phi_L(1)=L^2\ell_2$・辺の行ごとの分割・閉じた道の 1 対 1 対応・置換の符号の値・転送行列の巡回シフト不変性・組の貼り合わせの両向きの往復（2 件）・軌道ごとの置換の符号の値・軌道の互換の全単射性である。理由が台帳に残っているのは $\Phi_L(1)=L^2\ell_2$・辺の行ごとの分割・転送行列の巡回シフト不変性・組の貼り合わせの往復の 4 件だけで——1 つめは既存の主張をつなぐだけ、3 つめは番号の付け方そのもので抽象化すると同じ言明になるため、4 つめは前セクションの必要十分版を組の型へ書き写しただけで新しい仮定を要求しないため——残りは次のレビュー以降で 1 件ずつ判定する）。数え上げ側は有限型と有界な自然数値写像だけ、値の側は半環／可換モノイド／可換群／可換半環／狭義順序半環だけを仮定する |

2026-08-11 の tick 108 では、主張「多項式の値は係数の有限和で書ける」
（$k>n$ で係数が零のとき $\mathrm{aev}_{w}(f)=\sum_{k=0}^{n}\mathrm{ac}_k(f)\,w^{\,k}$）を
四層すべてで完了させ、SageMath 検証 `qbar-evaluation-coefficient-sum` と
必要十分版 `finite_sum_map_necSuf`（零元と 2 項の和を保つ写像は範囲にわたる有限和を保つ。
仮定は可換な加法モノイドだけ）を追加した。本文の主張は 122 件、sorry 検査の登録は 591 件。
必要十分版を置いていない主張は 9 件のままである。次は 10h3d-c4b-b2c4（因数定理そのもの）。

2026-08-11 の tick 109 では、根を持つ多項式が一次式を因子に持つことを四層すべてで完了した。
商を $g=\sum_{k=0}^{n}\widehat{\mathrm{ac}_k(f)}K_k(w)$ と構成し、根の条件と冪の差の
因数分解から $f=(t-\widehat w)g$ を得る。必要十分版は可換環上の有限和の言明まで薄めた。
次は「零でない多項式の根は次数を超えないこと」である。

2026-08-11 の tick 110 では、レビューで因数定理の鎖の第 5 段（根拠 3 つが 1 行に
まとまっていた）を 3 段へ割り（本文・Lean 具体版・SageMath を同じ粒度に保った）、
「零でない多項式の根は次数を超えないこと」を論法の数で 4 つへ割り直したうえで、最初の段
「冪の差の因数分解の商 $K_n(w)$ の係数は $n$ 以上の番号で零である」
（`claim_qbar_pow_diff_sum_coeff_bound`）を**記述と SageMath まで**進めた（$n$ についての
帰納法 1 本。Lean 具体版・必要十分版は未着手で、実行の列の先頭に積んである）。
本文のラベルは 244 件、検証と証明の対応は 98 件。次は同主張の Lean である。

2026-08-11 の tick 111 では、「冪の差の因数分解の商 $K_n(w)$ の係数は $n$ 以上の番号で
零である」を Lean でも完成させ、四層すべてを満たした。具体版は本文と同じ帰納法で、
定数多項式との積の係数も積の係数の有限和から取り出した。必要十分版は同じ証明を一般の半環係数で
行い、加法の逆元・積の可換性・体・代数閉性が不要であることを示す。次は、因数定理の商
$g=\sum_k\widehat{\mathrm{ac}_k(f)}K_k(w)$ の係数が $n$ 以上で零であること。`lake build` と
sorry 検査 600 件を含む検証一式は全通過した。

2026-08-11 の tick 112 では、「因数定理の商 $g=\sum_{k=0}^{n}\widehat{\mathrm{ac}_k(f)}\,K_k(w)$
の係数は $n$ 以上の番号で零である」を四層すべてで完了した。論法は有限和の係数へ前段の
係数上界を当てる鎖 1 本（11 段）で、根の条件 $\mathrm{aev}_{w}(f)=0$ は使わない。
必要十分版は係数環が半環で足りることに加え、係数の列が任意の写像 $c:\mathbb{N}\to R$ で
よい（多項式の係数であることを使わない）ことを示す。本文のラベルは 245 件、
検証と証明の対応は 99 件、sorry 検査の登録は 607 件。次は 10h3d-c4b-c3
（相異なる根における商の値が零であること）。

2026-08-11 の tick 113 では、「一次因子を取り除いた商は、もとの根と相異なる根で零になる」を
四層すべてで完了した。因子分解をもう一つの根で評価して
$0=(w'-w)\mathrm{aev}_{w'}(g)$ を得て、$w'-w\ne0$ から零でない因子を左から割る。
必要十分版は、多項式の型の積・それを保つ写像・因子の値とその左逆元だけを仮定する。
本文のラベルは 246 件、検証と証明の対応は 100 件、sorry 検査の登録は 610 件。
次は「零でない多項式の相異なる根は次数を超えないこと」の帰納法本体である。

2026-08-11 の tick 115 のレビューでは、tick 114 の定理 3 件が sorry 検査の検査対象の配列へ
登録されていなかった漏れを見つけ、本 tick の 3 件と合わせて 6 件を登録した（616 件で通過）。
そのあと、旧セクション「$\mu_n$ がちょうど $n$ 個」を論法の数で 5 つ（有限部分集合の上界・
$\mu_n$ 自身の有限性・単根性・下界の帰納法・組み立て）へ割り直し、最初の
「1 の冪根の全体の有限部分集合の元の個数は指数を超えない」を四層すべてで完了した。
準備の多項式 $f=t^{\,n}+\widehat{-1}$ の 3 条件を係数と評価の鎖で確かめ、相異なる根の
個数の上界を当てる。必要十分版は、上界を仮定として受け取れば、値の側に要るのが
零元との和の 2 規則・$1+m=0$ なる元・$1\ne0$ だけであることを示す（積も体も代数閉性も
不要。冪は記号として受け取るだけ）。本文のラベルは 248 件、検証と証明の対応は 102 件。
次は $\mu_n$ 自身が有限集合で元の個数が $n$ 以下であることである。

2026-08-11 の tick 114 のレビューでは、前 tick の異常終了時に残った修正を回収した。
因数定理が商の存在だけを主張していたため、後続の係数上界と相異なる根での零性が同じ商を
指す保証が statement に無かった。商
$g=\sum_{k=0}^{n}\widehat{\mathrm{ac}_k(f)}K_k(w)$ を因数定理の statement に明示し、
Lean の具体版・必要十分版・導出も同じ商についての等式へ揃えた。検証一式は全通過した。
そのあと「零でない多項式の相異なる根は係数の上界を超えない」を四層すべてで完了した。
根を一つ選び、因数定理の明示的な商へ残りの根を移して係数の上界を一つ下げる帰納法である。
必要十分版は、多項式・係数・評価を使わず、根を一つ取り除く抽象操作と上界の述語だけを要求する。
本文のラベルは 247 件、検証と証明の対応は 101 件。次は $\mu_n$ がちょうど $n$ 個の元を
持つこと（有限性の仮定を外す段）である。

Lean の環境は 2026-08-08 に整えた。`lake update` → `lake exe cache get` → `lake build` が通り、
mathlib の実体は `lean/lake-manifest.json` で固定してある（`.lake/` は git 管理外）。
詳細は [lean/README.md](lean/README.md)。

書いた内容は、格子・配位・破れボンド数・多重度・分配多項式 $Z_L\in\mathbb{Z}[x]$ の定義と、
次の 3 つの主張の証明である。この範囲に $\mathbb{R}/\mathbb{C}$ は現れない。

- 配位全体は破れボンド数の値ごとに類別される（被覆と互いに素性）。
- 分配多項式の係数は多重度である（$Z_L=\sum_{m=0}^{2L^2}\Omega_L(m)x^m$）。
  分配多項式の定義は $\sum_{\sigma}x^{b(\sigma)}$ であり、係数表示は定義ではなく主張である。
- 多重度の総和は配位の総数に等しい（$\sum_m\Omega_L(m)=2^{L^2}$）。

章「有限系の自由エントロピー」では、素因数分解の指数 $v_p$、対数順序群
$\Lambda=\{\,\lambda:\mathcal{P}\to\mathbb{Z}\ \text{有限台}\,\}$、正の有理数の対数
$\log q=\sum_p w_p(q)\ell_p$、および $\Phi_L(q)=\log Z_L(q)$ を定義し、次の 2 つを示した。
この範囲にも $\mathbb{R}/\mathbb{C}$ は現れない（$\log$ は級数でも実対数でもなく素因数分解である）。

- 有理数の指数は表示の取り方によらない（$a/b=a'/b'$ ならば $v_p(a)-v_p(b)=v_p(a')-v_p(b')$）。
- 分配多項式の正の有理点での値は正の有理数である（したがって $\Phi_L(q)$ が定まる）。
- 対数の加法性 $\log(q_1q_2)=\log q_1+\log q_2$。これが $\log$ を対数と呼ぶ根拠である。
- 対数の冪の法則 $\log(q^k)=k\log q$（$k\in\mathbb{N}$。$k=0$ の場合が $\log 1=0$）。
- $\Phi_L(1)=L^2\ell_2$。すべての配位を等しく数える点での自由エントロピーは配位の総数の対数に等しい。

章「転送行列」では、行配位 $\tau\in R_L$、配位の第 $i$ 行への制限 $\rho_i(\sigma)$、
行内破れ数 $b_\mathrm{h}$、行間破れ数 $b_\mathrm{v}$ を定義し、次の 2 つを示した。
この範囲にも $\mathbb{R}/\mathbb{C}$ は現れない。

- 辺の番号の集合は行ごとに分割される（各行 $L$ 本・互いに素・合併がもとの集合・端点が番号から読める）。
- 破れボンド数は行内の破れと行間の破れに分かれる
  （$b(\sigma)=\sum_i b_\mathrm{h}(\rho_i(\sigma))+\sum_i b_\mathrm{v}(\rho_i(\sigma),\rho_{i+1}(\sigma))$）。
  これが転送行列を作る足場である。第 1 の和は行ごとに閉じ、第 2 の和は隣り合う 2 行だけを結ぶ。

さらに、行配位の族 $C_L$ と写像 $\mathrm{rows}:\Sigma_L\to C_L$・$\mathrm{conf}:C_L\to\Sigma_L$、
行配位を添字とする行列 $\mathrm{Mat}_{R_L}(\mathbb{Z}[x])$ とその積・冪・トレース、および転送行列
$T_{\tau,\tau'}=x^{b_\mathrm{h}(\tau)+b_\mathrm{v}(\tau,\tau')}$ を定義し、次の 2 つを示した。
指数形 $e^{K\sigma\sigma'}$ は経由していない。

- 配位全体と行配位の族全体は 1 対 1 に対応する（$\mathrm{rows}$ が全単射で逆写像が $\mathrm{conf}$）。
- 配位の重みは行に沿った転送行列の成分の積である
  （$\prod_i T_{\rho_i(\sigma),\rho_{i+1}(\sigma)}=x^{b(\sigma)}$）。
  すなわち分配多項式の和の 1 つの項が、転送行列の成分から得られる。

さらに、長さ $k$ の道（写像 $p:\{0,1,\dots,k\}\to R_L$ の全体）と道に沿った成分の積
$w_A(p)=\prod_{i=0}^{k-1}A_{p(i),p(i+1)}$ を定義し、次を示した。道の定義域は整数の集合であり、
行配位の族（剰余類の集合の上の写像）とは別の対象である。

- 行列の冪の成分は、道に沿った成分の積の和である
  （$(A^k)_{\tau,\tau''}=\sum_{p\in W_{L,k}(\tau,\tau'')}w_A(p)$。$k$ についての帰納法）。

さらに、閉じた道の全体 $W^{\mathrm{cl}}_L=\{p\in W_{L,L}\mid p(0)=p(L)\}$ と、行配位の族から
閉じた道を作る写像 $\Theta$（$(\Theta(c))(i)=c(\pi(i))$）・その逆向きの $\Xi$ を定義し、
章「転送行列」の目標を示した。ここにも $\mathbb{R}/\mathbb{C}$ は現れない。

- 行配位の族全体と閉じた道全体は 1 対 1 に対応する（$\Theta$ が全単射で逆写像が $\Xi$）。
- 分配多項式は転送行列の冪のトレースである（$Z_L=\operatorname{Tr}(T^L)$）。
  $2^{L^2}$ 個の項の和として定義された分配多項式が、$2^L$ 次の行列の冪から計算できることになる。

章「固有値の代数性」では、行列式を書くために要る添字集合の線形順序を用意した。
スピン値の番号 $\varepsilon(+1)=0$・$\varepsilon(-1)=1$、値の異なる列番号の集合
$D(\tau,\tau')\subset\{0,\dots,L-1\}$、その最小元 $k_0$、および
$\tau\prec\tau'\iff\tau\ne\tau'$ かつ $k_0$ の位置で $\varepsilon$ の値が小さい、を定義し、次を示した。
ここにも $\mathbb{R}/\mathbb{C}$ は現れない。

- 行配位の辞書式順序は線形順序である（三分律と推移律）。
  行配位に番号を付けて番号の大小を借りると番号の付け方に依存するので、$R_L$ の上に直接定めた。

さらに、置換の全体 $\mathfrak{S}_L$（$R_L$ から $R_L$ への全単射の全体）、順序づけられた対の全体
$P_L$、転倒数 $\mathrm{inv}(\varphi)\in\mathbb{N}$、および符号
$\mathrm{sgn}(\varphi)=(-1)^{\mathrm{inv}(\varphi)}\in\mathbb{Z}$ を定義し、次の 2 つを示した。
置換を表す記号は $\varphi,\psi$ である（$\pi$ は射影に固定してあるので使わない）。

- 符号は $+1$ か $-1$ であり、その 2 乗は $1$、恒等写像の符号は $+1$ である。
- 符号は合成について乗法的である（$\mathrm{sgn}(\varphi\circ\psi)=\mathrm{sgn}(\varphi)\mathrm{sgn}(\psi)$）。
  必要十分版が示したのは、この証明が三分律しか使っておらず、**推移律を使っていない**ことである。

さらに、整数から定数多項式を与える写像 $\kappa:\mathbb{Z}\to\mathbb{Z}[x]$、単位行列 $I$、そして行列式
$\det A=\sum_{\varphi\in\mathfrak{S}_L}\kappa(\mathrm{sgn}(\varphi))\prod_{\tau\in R_L}A_{\tau,\varphi(\tau)}$
を定義し、次の 2 つを示した。$\kappa$ を明示的に置いたのは、整数と定数多項式を同じ記号で書かないためである。
積 $\prod_{\tau\in R_L}$ に添字の順序は要らない（$\mathbb{Z}[x]$ の積が可換だから）。
すなわち順序 $\prec$ が要るのは符号を転倒数で定める箇所だけである。

- 恒等写像でない置換は少なくとも 2 つの行配位を動かす（$|M(\varphi)|\ge2$）。
- 対角行列の行列式は対角成分の積である（$\det A=\prod_\tau A_{\tau,\tau}$）。とくに $\det I=\kappa(1)$。
  必要十分版が示したのは、この証明が値の側に可換半環しか要求せず（引き算を一度も使っていない）、
  重みには $w(\mathrm{id})=1$ しか要求しないこと、すなわち**符号の乗法性を使っていない**ことである。

この 2 つは、特性多項式の次数を数えるための道具である。

さらに、特性多項式を書く場所として、$\mathbb{Z}[x]$ を係数環とするもう 1 つの不定元 $t$ の
多項式環 $\mathbb{Z}[x][t]$、係数写像 $\mathrm{cf}_k$、$\mathbb{Z}[x]$ の元を定数として送る写像
$\iota$、次数が $n$ 以下である元の全体 $\mathcal{D}_n$、モニックな次数 $n$ の元の全体
$\mathcal{M}_n$ を定義し、次の 4 つを示した。ここにも $\mathbb{R}/\mathbb{C}$ は現れない。

**不定元を $\lambda$ と書かない。** $\lambda$ は対数順序群 $\Lambda$ の元を表す記号として
固定してあるためである（README「1 つの記号は 1 つの意味に固定する」）。

- $\mathcal{D}_n$ の元の有限和は $\mathcal{D}_n$ の元である。
- 次数の上界は有限積で足し合わされる（$f_s\in\mathcal{D}_{n_s}$ なら
  $\prod_s f_s\in\mathcal{D}_{\sum_s n_s}$）。
- モニックな元の有限積はモニックであり、その次数は次数の和である。
- モニックな元に次数の低い元を足してもモニックである。
  必要十分版が示したのは、この 4 つの証明が係数環に**半環しか要求しない**ことである
  （引き算も、零因子が無いことも使っていない。2 元の補題は積の可換性さえ使っていない）。

次数を写像として定めず上界の条件として定めたのは、零多項式の次数を決める約束を要らなくするためである。

さらに、$\mathbb{Z}[x][t]$ を成分とする行列 $\mathrm{Mat}_{R_L}(\mathbb{Z}[x][t])$、その行列式
$\mathrm{det}_{t}$、不定元 $t$ 自身が定める元、特性行列 $\mathrm{ch}(A)$、そして特性多項式
$\chi_A=\mathrm{det}_{t}(\mathrm{ch}(A))$ を定義し、次の 3 つを示した。ここにも $\mathbb{R}/\mathbb{C}$ は現れない。

**特性行列は $\mathrm{ch}(A)_{\tau,\tau'}=t+\iota(-A_{\tau,\tau'})$（対角では $t$ を足す）と書く。**
通常 $tI-A$ と書かれる行列だが、符号の反転を $\mathbb{Z}[x]$ の中で先に済ませておくと、
以降の議論に $\mathbb{Z}[x][t]$ の引き算が一度も現れない。

- $\iota(a)\in\mathcal{D}_0$（定数として送った元の次数は 0 以下である）。
- $t+\iota(a)\in\mathcal{M}_1$（不定元に定数を足したものはモニックな次数 1 の元である）。
- $\chi_A\in\mathcal{M}_{2^{L}}$（特性多項式はモニックな次数 $2^{L}$ の元である）。
  必要十分版が示したのは、この証明が重みに要求するのが $w(\mathrm{id})=1$ と「次数を上げないこと」
  だけであり、**符号の乗法性も、符号が $\pm1$ であることも使っていない**ことである。

さらに、列番号の平行移動 $\gamma(y)=y+_{\mathbb{Z}/L\mathbb{Z}}\bar1$ と、それで行配位を引き戻す
巡回シフト $\bigl(S(\tau)\bigr)(y)=\tau(\gamma(y))$ を定義し、次の 5 つを示した。
ここにも $\mathbb{R}/\mathbb{C}$ は現れない。

- $\gamma$ は全単射である（逆向きの平行移動との往復が恒等写像）。
- $S$ は全単射である（$\gamma$ の逆写像で引き戻す写像が逆写像）。
- 行内破れ数は巡回シフトで変わらない（$b_{\mathrm{h}}(S(\tau))=b_{\mathrm{h}}(\tau)$）。
- 行間破れ数は 2 つの行配位を同時に巡回シフトしても変わらない
  （$b_{\mathrm{v}}(S(\tau),S(\tau'))=b_{\mathrm{v}}(\tau,\tau')$）。
- 転送行列の成分は行と列を同時に巡回シフトしても変わらない（$T_{S(\tau),S(\tau')}=T_{\tau,\tau'}$）。
  必要十分版が示したのは、破れ数についての 2 主張が**同じ 1 つの数え上げの補題の、述語の取り方が
  違うだけの特殊化**であること、すなわち破れ数が「値の相違を数えたもの」であることを使っていないことである。
  平行移動の全単射性は加法群であることしか使っておらず、可換性も有限性も使っていない。

さらに、巡回シフトを成分へ書き写したシフト行列
$U_{\tau,\tau'}=\kappa(1)\ (\tau'=S(\tau))$、$\kappa(0)$（それ以外）を定義し、次の 3 つを示した。
ここにも $\mathbb{R}/\mathbb{C}$ は現れない（成分は $\mathbb{Z}[x]$）。

- シフト行列を左から掛けると行の添字がシフトされる（$(UA)_{\tau,\tau''}=A_{S(\tau),\tau''}$）。
- シフト行列を右から掛けると列の添字が逆向きにシフトされる（$(AU)_{\tau,\tau''}=A_{\tau,S'(\tau'')}$。
  $S'$ は $S$ の逆写像）。この 2 つは任意の行列 $A$ についての主張である。
- シフト行列と転送行列は可換である（$UT=TU$）。
  必要十分版が示したのは 2 点である。この証明が値の側に要求するのは単位元・零元の 4 規則と
  有限和だけで、**分配則も積の結合則も積の可換性も使っていない**。そして可換性が行列に要求するのは
  シフトによる不変性ただ 1 つで、**$A$ が転送行列であることを使っていない**。

さらに、平行移動の反復 $\gamma^{[k]}$（$\gamma^{[k+1]}=\gamma^{[k]}\circ\gamma$）と
巡回シフトの反復 $S^{[k]}$（$S^{[k+1]}=S\circ S^{[k]}$）を定義し、次の 5 つを示した。
ここにも $\mathbb{R}/\mathbb{C}$ は現れない。

**2 つの反復で合成の順を変えている。** 噛み合わせの主張の帰納法が、帰納法の仮定を
$y$ ではなく $\gamma(y)$ へ当てる形になるためで、その理由は本文に書いてある。
上付きの角括弧は、これが積の反復ではなく合成の反復であることを記号に残すためのものである。

- $\gamma^{[k]}(y)=y+_{\mathbb{Z}/L\mathbb{Z}}\pi(k)$。
- $\gamma^{[L]}=\mathrm{id}$（$\pi(L)=0$ による）。
- $(S^{[k]}(\tau))(y)=\tau(\gamma^{[k]}(y))$（2 つの反復の噛み合わせ）。
- $S^{[L]}=\mathrm{id}$。
- $(U^{k})_{\tau,\tau'}$ は $\tau'=S^{[k]}(\tau)$ のとき $\kappa(1)$、そうでないとき $\kappa(0)$。
- シフト行列の $L$ 乗は単位行列である（$U^{L}=I$）。
  必要十分版が示したのは、平行移動の反復が加法モノイドしか使っていないこと、
  引き戻しの反復が値の型にも添字の型にも何も要求しないこと、そして $U^{L}=I$ が要求するのが
  「$L$ 回の反復が恒等写像であること」だけで、**$e$ の位数がちょうど $L$ であることは
  使っていない**ことである。

さらに、行配位 $\tau$ をもとへ戻す反復の回数の全体
$K(\tau)=\{k\in\mathbb{N}\mid k\ge1,\ S^{[k]}(\tau)=\tau\}$ の最小元として最小周期 $e(\tau)$ を定め、
次の 3 つを示した。ここにも $\mathbb{R}/\mathbb{C}$ は現れない。

- 反復の回数は足し算になる（$S^{[a+b]}(\tau)=S^{[a]}(S^{[b]}(\tau))$）。
- もとへ戻る反復の回数は最小周期の倍数である（$S^{[k]}(\tau)=\tau\iff e(\tau)\mid k$）。
  証明は自然数の除法 $k=e(\tau)q+r$ を使い、$r\ge1$ が最小性に反することで $r=0$ を出す。
- 最小周期は格子の一辺を割り切る（$e(\tau)\mid L$）。
  必要十分版が示したのは、これらが要求するのが「その点が 1 回以上の反復でもとへ戻ること」という
  点ごとの仮定だけであり、$S$ が全単射であることも $R_L$ が有限であることも、
  $S$ の位数が $L$ であることも使っていないことである。

さらに、$\tau$ から巡回シフトの反復で到達できる行配位の全体（軌道）
$O(\tau)=\{\tau'\in R_L\mid \tau'=S^{[k]}(\tau)\ \text{を満たす}\ k\in\mathbb{N}\ \text{が存在する}\}$ を定義し、
次の 2 つを示した。ここにも $\mathbb{R}/\mathbb{C}$ は現れない。

- 反復した巡回シフトは単射である（$k$ についての帰納法。一歩は $S$ の単射性）。
- 軌道の元の個数は最小周期に等しい（$\lvert O(\tau)\rvert=e(\tau)$）。
  証明は写像 $\eta_\tau(k)=S^{[k]}(\tau)$ を $\{k\in\mathbb{N}\mid k<e(\tau)\}$ から $O(\tau)$ へ置き、
  単射性と全射性を別々に示す。写像の名前に $\Omega$ を使えない（多重度 $\Omega_L(m)$ に固定してある）
  ので $\eta_\tau$ とした。
  必要十分版が示したのは、これらが要求するのが「写像が単射であること」「添字の型が有限で
  相等が判定できること」「その点が 1 回以上の反復で戻ること」の 3 つだけであり、
  すなわち $S$ が全単射であることの半分（単射性）しか使っていないことである。

さらに、軌道の全体 $\mathcal{O}_L=\{O(\tau)\mid\tau\in R_L\}$ を定義し、次の 3 つを示した。
ここにも $\mathbb{R}/\mathbb{C}$ は現れない。

- 軌道の元の軌道はもとの軌道に等しい（$\tau'\in O(\tau)$ ならば $O(\tau')=O(\tau)$）。
  証明は包含の補題「$\tau_2\in O(\tau_1)$ ならば $O(\tau_2)\subset O(\tau_1)$」を 2 度当てる。
  2 度目に要る $\tau\in O(\tau')$ は、$S$ を逆向きに辿るのではなく、反復の回数
  $k_0=(e(\tau)-1)\,m$ を取って前向きに戻ることで得る。
- 2 つの軌道は一致するか互いに素である。
- 軌道の全体は行配位の全体の分割である（どの元も空でない・相異なる 2 元は互いに素・合併が $R_L$）。
  必要十分版が示したのは、これらが要求するのが「その点が 1 回以上の反復で戻ること」だけで、
  **$S$ の単射性も全射性も、最小周期の最小性も使っていない**ことである。

さらに、軌道を保つ置換の全体
$\mathfrak{S}^{\mathcal{O}}_L=\{\varphi\in\mathfrak{S}_L\mid\text{任意の }\tau\text{ について }\varphi(\tau)\in O(\tau)\}$
を定義し、次の 4 つを示した。ここにも $\mathbb{R}/\mathbb{C}$ は現れない。

- シフト行列の特性行列の成分は、列の添字が行の添字でもその像でもないとき零元である
  （$\tau'\ne\tau$ かつ $\tau'\ne S(\tau)$ ならば $\mathrm{ch}(U)_{\tau,\tau'}=\iota(\kappa(0))$）。
- そのような値を取る置換の項は零元である（$\chi_U$ の和に寄与しない）。
  したがって零元でない項を持ちうるのは、各 $\tau$ を $\tau$ か $S(\tau)$ へ送る置換だけである。
- 各行配位をそれ自身かその像へ送る置換は軌道を保つ（逆は成り立たない。$L=3$ で前者は 4 個、
  後者は 36 個ある）。
- 軌道を保つ置換は各軌道をそれ自身へ写す（$\varphi(O)=O$）。証明は包含と個数の 2 段。
  必要十分版が示したのは、項が消えることの本体が重みに**何も要求せず**係数環も可換半環でよいこと
  （負号は特性行列の定義に現れるだけで証明には現れない）、および $\varphi(O)=O$ が使う単射性が
  **置換 $\varphi$ のもの**であって $S$ については何も要求しないことである。

さらに、軌道を保つ置換 $\varphi$ の各軌道 $O$ への制限
$\varphi\!\restriction_{O}:O\to O$、$(\varphi\!\restriction_{O})(\tau)=\varphi(\tau)$ を定義し、
次の 2 つを示した。ここにも $\mathbb{R}/\mathbb{C}$ は現れない。

行き先が $O$ に収まることは定めるだけでは言えないので、$\varphi(O)=O$ から出す段を定義の中に書いた。

- 軌道への制限はその軌道の上の全単射である（単射性と全射性を別々に示す）。
- 制限の全体が一致する軌道を保つ置換は一致する（対応が単射であること）。
  証明が使うのは「どの $\tau$ も自分の軌道に属すること」だけであり、
  軌道どうしが互いに素であることは使っていない（それが効くのは逆向きの構成の側である）。
  必要十分版が示したのは、制限の構成と全単射性が要求するのが
  **その集合が置換の像で閉じていること $O.\mathrm{image}\,\varphi=O$ だけ**であり、
  その集合が軌道であることも添字の型が有限であることも使っていないこと、
  および制限が置換を決めることが要求するのが**族が全体を覆うことだけ**であることである。

さらに、軌道ごとの置換の組の全体
$\mathfrak{A}_L=\{\alpha\mid\alpha\ \text{は各}\ O\in\mathcal{O}_L\ \text{へ}\ O\ \text{の上の全単射}\ \alpha(O)\ \text{を対応させる}\}$
と、その貼り合わせ $\bigl(\mathrm{gl}(\alpha)\bigr)(\tau)=\bigl(\alpha(O(\tau))\bigr)(\tau)$ を定義し、
次の 3 つを示した。ここにも $\mathbb{R}/\mathbb{C}$ は現れない。

組を表す記号に $\sigma$ を使わない（格子全体の配位に固定してある）ので $\alpha$ とした。

- 貼り合わせは行配位の全体の上の全単射である（$\mathrm{gl}(\alpha)\in\mathfrak{S}_L$）。
  **単射性で軌道どうしが互いに素であることが効く。** 行き先が一致する 2 つの行配位について、
  共通の値が両方の軌道に属することから軌道の一致を出し、そこで同じ組の成分の単射性を当てる。
- 貼り合わせは軌道を保つ置換である（$\mathrm{gl}(\alpha)\in\mathfrak{S}^{\mathcal{O}}_L$）。
- 貼り合わせの各軌道への制限はもとの組に一致する（$\mathrm{gl}(\alpha)\!\restriction_{O}=\alpha(O)$）。
  前の主張（制限の全体が置換を決めること）と合わせて、$\mathfrak{S}^{\mathcal{O}}_L$ と
  $\mathfrak{A}_L$ が 1 対 1 に対応する。
  必要十分版が示したのは、貼り合わせの構成が要求するのが**各点にその点を含む集合が 1 つ
  指定されていることだけ**であり、全単射性と制限の一致が要求するのが「点の属する集合が
  一意であること」と「族の各元の上で組が全単射であること」だけであることである。

さらに、2 つの軌道にまたがる対の全体
$F(O,O')=\{(\tau,\tau')\in O\times O'\mid\tau\prec\tau'\}$、
$F_\varphi(O,O')=\{(\tau,\tau')\in O\times O'\mid\varphi(\tau)\prec\varphi(\tau')\}$、
およびまたがる転倒対の全体 $J_\varphi(O,O')$ を定義し、次の 2 つを示した。
ここにも $\mathbb{R}/\mathbb{C}$ は現れない。

入れ替えの写像を $\mathrm{sw}$ と書く（$\Sigma$ は格子全体の配位の集合 $\Sigma_L$ に固定してある）。

- 軌道を保つ置換はまたがる順序づけられた対の個数を変えない（$|F_\varphi(O,O')|=|F(O,O')|$）。
  証明は $\Upsilon(\tau,\tau')=(\varphi(\tau),\varphi(\tau'))$ が $O\times O'$ の上の全単射で、
  $F_\varphi$ をちょうど $F$ へ写すことによる。
- 2 つの相異なる軌道にまたがる転倒対の個数は偶数である
  （$|J_\varphi(O,O')|=2\,|F(O,O')\setminus F_\varphi(O,O')|$）。
  証明は $J_\varphi$ を $J_1$・$J_2$ へ分け、$J_1=F\setminus F_\varphi$、
  $J_2$ が $\mathrm{sw}$ で $F_\varphi\setminus F$ と 1 対 1 に対応すること、
  そして前の主張から $|F\setminus F_\varphi|=|F_\varphi\setminus F|$ が出ることによる。
  必要十分版が示したのは、前者が要求するのが $\varphi$ と $\varphi^{-1}$ が 2 つの集合を
  保つことだけ（$\prec$ には何も要求しない）であり、後者が要求するのが
  それに加えて 2 つの集合が交わらないことと $\prec$ の三分律だけであること、
  すなわち**推移律を使っていない**ことである。

これは、置換の符号を軌道ごとの符号の積へ分解する（またがる対の寄与が $(-1)$ の冪に効かない）
ための足場である。

さらに、転倒対の全体 $\mathrm{Inv}(\varphi)=\{(\tau,\tau')\in P_L\mid\varphi(\tau')\prec\varphi(\tau)\}$、
軌道の上の全単射の転倒数 $\mathrm{inv}_O(\psi)$（台は $F(O,O)$）、および軌道をまたぐ転倒対の全体
$\mathrm{Inv}^{\ne}(\varphi)=\{(\tau,\tau')\in\mathrm{Inv}(\varphi)\mid O(\tau)\ne O(\tau')\}$ を定義し、
次の 2 つを示した。ここにも $\mathbb{R}/\mathbb{C}$ は現れない。

大文字の $\mathrm{Inv}$ は集合、小文字の $\mathrm{inv}$ はその個数であり、別の対象である。

- 1 つの軌道の中の転倒対の個数は、その軌道への制限の転倒数である
  （$|\{(\tau,\tau')\in\mathrm{Inv}(\varphi)\mid\tau,\tau'\in O\}|=\mathrm{inv}_O(\varphi\!\restriction_O)$）。
  示しているのは**集合の等号**であり、個数はそこから取る（1 対 1 対応は作らない）。
- 転倒数は、軌道ごとの転倒数の和と、またぐ転倒対の個数の和である
  （$\mathrm{inv}(\varphi)=\sum_{O\in\mathcal{O}_L}\mathrm{inv}_O(\varphi\!\restriction_O)+|\mathrm{Inv}^{\ne}(\varphi)|$）。
  証明は 3 段で、述語 $O(\tau)=O(\tau')$ による 2 分割、同じ軌道の側を軌道ごとに分けること、
  そして個数を数えることである。
  必要十分版が示したのは、集合の等号が要求するのは台が $\prec$ で順序づけられた対を
  ちょうど集めていることだけであり、分解が要求するのは「各点にその点を含む族の元が 1 つ
  指定されていること」と「族の元に属する点にはその元が指定されていること」だけであること、
  すなわち**関係 $\prec$ の性質を一つも使っていない**（非対称性も三分律も推移律も要らない）ことである。
  前のセクションの偶数性が三分律を要求したのと対照的である。

これは、シフト行列の特性多項式を軌道ごとの因子 $t^{\lvert O\rvert}-1$ の積へ分解し、
その根が 1 の $L$ 乗根であることを言うための足場である。
軌道の大きさが $L$ の約数であることから、$\overline{\mathbb{Q}}$ を持ち出す前に
「$\chi_U$ が $(t^{L}-1)$ の冪を割る」という $\mathbb{Z}[t]$ の中の整除関係として書ける。

さらに、行配位の空でない部分集合 $X\subset R_L$ の最小元 $\mu(X)$ を定義し、次の 2 つを示した。
ここにも $\mathbb{R}/\mathbb{C}$ は現れない。

$\mu(X)$ は集合ではなく $R_L$ の元であり、$X$ が空のときは定まらない。

- 空でない部分集合は $\prec$ の最小元をちょうど 1 つ持つ。
  証明は、存在が元の個数についての帰納法（1 元の場合から始め、元を 1 つ足す）、
  一意性が三分律の「ちょうど 1 つ」による背理法である。
  **この証明は推移律を使う**（またがる転倒対の偶数性が三分律だけで通ったのと対照的である）。
- 相異なる軌道の最小元は相異なる（$\mu(O)\in O$ と、相異なる軌道が互いに素であることによる）。
  必要十分版が示したのは、存在が要求するのは「相異なる 2 点が比較できること」と推移律だけで
  **非対称性は一意性の側でだけ要る**こと、および後者が**最小元の理論に属さず**
  「交わらない 2 つの集合から取った 2 点は相異なる」という言明でしかないことである。

これは、またぐ転倒対の全体の個数が偶数であることを示すための足場である。
軌道の対ごとの偶数性を足し合わせるとき $(O,O')$ と $(O',O)$ を 2 度数えないよう、
軌道の順序対の全体を $\mu(O)\prec\mu(O')$ かどうかで半分に分ける。

さらに、最小元で向きを付けた軌道の順序対の全体
$\mathcal{D}_L=\{(O,O')\in\mathcal{O}_L\times\mathcal{O}_L\mid\mu(O)\prec\mu(O')\}$ を定義し、
次の 3 つを示した。ここにも $\mathbb{R}/\mathbb{C}$ は現れない。

- $\mathcal{D}_L$ の相異なる 2 元が与えるまたがる転倒対は交わらない。
- またぐ転倒対の全体は、$\mathcal{D}_L$ にわたる $J_\varphi$ の合併である
  （$\mathrm{Inv}^{\ne}(\varphi)=\bigcup_{(O,O')\in\mathcal{D}_L}J_\varphi(O,O')$。集合の等号として示した）。
- またぐ転倒対の全体の個数は偶数である
  （$|\mathrm{Inv}^{\ne}(\varphi)|=2\sum_{(O,O')\in\mathcal{D}_L}|F(O,O')\setminus F_\varphi(O,O')|$）。
  必要十分版が示したのは、これらが $\mathcal{D}_L$ に要求するのが「向きについて非対称であること」と
  「相異なる 2 元の順序対の一方を含むこと」だけであり、**最小元そのものは使っていない**ことである。
  すなわち最小元は、その 2 条件を満たす集合を 1 つ作るための手段でしかない。

これで、置換の符号を軌道ごとの符号の積へ分解する足場が揃った
（転倒数の分解の第 2 項が偶数なので、$(-1)$ の冪に効かない）。

さらに、軌道 $O$ の上の全単射 $\psi$ の符号
$\mathrm{sgn}_{O}(\psi)=(-1)^{\mathrm{inv}_{O}(\psi)}\in\mathbb{Z}$ を定義し、次を示した。
ここにも $\mathbb{R}/\mathbb{C}$ は現れない（個数は $\mathbb{N}$、符号は $\mathbb{Z}$）。

$\mathrm{sgn}_{O}$ と $\mathrm{sgn}$ は定義域の違う別の写像である
（前者の引数は $O$ の上の全単射、後者の引数は $R_L$ の上の置換）。

- 軌道を保つ置換の符号は軌道ごとの符号の積である
  （$\mathrm{sgn}(\varphi)=\prod_{O\in\mathcal{O}_L}\mathrm{sgn}_{O}(\varphi\!\restriction_{O})$）。
  証明は、またぐ転倒対の個数の偶数性から $k$ を取って準備とし、そのうえで 9 段の一続きの鎖である。
  転倒数の分解を指数へ代入し、指数法則で 2 つの冪へ割り、またぐ側を
  $(-1)^{2k}=((-1)^2)^k=1^k=1$ で落とし、最後に有限和を指数とする冪を冪の有限積へ開く。
  必要十分版が示したのは、値の側に要求するのが**可換モノイドと $u\cdot u=1$ だけ**であり
  （$u=-1$ であることも引き算があることも使わない）、指数について要求するのが
  $n=\bigl(\sum_{i\in s}f(i)\bigr)+2k$ という分解だけであること、すなわち
  **順序 $\prec$ も軌道もこの段には現れない**ことである。

これで、シフト行列の特性多項式 $\chi_U$ を軌道ごとの因子の積へ組み替える材料が揃った。

さらに、軌道の因子
$W_{O}(B,\psi)=\iota\bigl(\kappa(\mathrm{sgn}_{O}(\psi))\bigr)\cdot\prod_{\tau\in O}B_{\tau,\psi(\tau)}\in\mathbb{Z}[x][t]$
を定義し、次の 3 つを示した。ここにも $\mathbb{R}/\mathbb{C}$ は現れない。

$W_{O}$ の第 1 引数に行列を書くのは、この因子が $B$ ごとに違う元だからである。

- $\iota\circ\kappa$ は有限積を有限積へ写す（$\iota(\kappa(\prod_i n_i))=\prod_i\iota(\kappa(n_i))$）。
  使うのは単位元と積を保つことだけで、和を保つことは使わない。
- 行配位の全体にわたる有限積は、軌道ごとの有限積の積である
  （$\prod_{\tau\in R_L}f(\tau)=\prod_{O}\prod_{\tau\in O}f(\tau)$）。
  使うのは分割の 3 条件のうち合併と互いに素であることの 2 つだけである。
- 軌道を保つ置換が与える項は、軌道ごとの因子の積である
  （$\iota(\kappa(\mathrm{sgn}(\varphi)))\cdot\prod_{\tau\in R_L}B_{\tau,\varphi(\tau)}=\prod_{O}W_{O}(B,\varphi\!\restriction_{O})$）。
  必要十分版が示したのは、この段が 2 つの分解（符号の積表示と積の軌道ごとの分解）を
  受け取ってしまえば可換モノイドの性質しか使わず、**順序 $\prec$ も軌道の作り方も現れない**ことである。

さらに、シフト行列の特性多項式 $\chi_U$ の和を軌道を保つ置換だけに絞り、各項を軌道ごとの
因子の積へ置き換えた。ここにも $\mathbb{R}/\mathbb{C}$ は現れない。

- 軌道を保たない置換の項は零元である。証明は「各行配位をそれ自身かその像へ送る置換は
  軌道を保つ」の対偶で $\varphi(\tau_1)\ne\tau_1$ かつ $\varphi(\tau_1)\ne S(\tau_1)$ を
  満たす $\tau_1$ を取り、「その置換の項は零元である」を当てるだけである。
- $\chi_U=\sum_{\varphi\in\mathfrak{S}^{\mathcal{O}}_L}\prod_{O}W_{O}(\mathrm{ch}(U),\varphi\!\restriction_{O})$。
  証明は 4 段の一続きの鎖（特性多項式の定義・行列式の定義・零元である項を落として和を狭める・
  各項へ項の分解を当てる）である。
  必要十分版が示したのは、項が零元であることの段が値の側に**何の構造も要求しない**こと
  （2 つの含意を対偶でつなぐだけ）と、和を狭める段が要求するのが可換な加法モノイドと
  「狭める先の外で項が零元であること」だけであることである。
  Lean では、和の添字にするために軌道を保つ置換の全体を有限集合として持ち直した
  （述語との一致は主張として示してある）。

さらに、軌道を保つ置換 $\varphi$ が定める軌道ごとの置換の組
$\bigl(\mathrm{res}(\varphi)\bigr)(O)=\varphi\!\restriction_{O}$ を定義し、次の 3 つを示した。
ここにも $\mathbb{R}/\mathbb{C}$ は現れない。

$\mathrm{res}(\varphi)$ は 1 つの写像ではなく写像の組であり、その $O$ における値が写像である。
$\mathrm{res}$ の定義域は $\mathfrak{S}^{\mathcal{O}}_L$ であって $\mathfrak{S}_L$ ではない。

- 制限の組を貼り合わせるともとの置換に戻る（$\mathrm{gl}(\mathrm{res}(\varphi))=\varphi$）。
- 貼り合わせの制限の組はもとの組に戻る（$\mathrm{res}(\mathrm{gl}(\alpha))=\alpha$）。
  この 2 つで $\mathrm{res}$ と $\mathrm{gl}$ が互いに逆であることが言えた。
- $\chi_U=\sum_{\alpha\in\mathfrak{A}_L}\prod_{O}W_{O}(\mathrm{ch}(U),\alpha(O))$。
  前の主張との違いは和の添字だけである。
  必要十分版が示したのは、はじめの 2 主張が前セクションの必要十分版を組の型へ
  書き写しただけで新しい仮定を要求しないこと、すなわち新しく必要十分性を問うべきなのは
  和の添字の取り替えだけであり、それが要求するのは**2 つの写像が互いに逆であることと
  可換な加法モノイドだけ**であることである。
  Lean では、和の添字にするために組の全体を依存関数型として持ち直した
  （前セクションの「どの有限集合にも写像を与える対応」は、軌道でない有限集合における値が
  自由なので和の添字にできない）。

さらに、1 つの軌道 $O$ の上の全単射の全体 $\mathfrak{B}_{O}$ と、軌道の部分集合
$s\subset\mathcal{O}_L$ ごとの置換の組の全体 $\mathfrak{A}(s)$ を定義し、次を示した。
ここにも $\mathbb{R}/\mathbb{C}$ は現れない。

$\mathfrak{A}(s)$ は $\mathfrak{A}_L$ を $s$ について動かせるようにしたものであり、
$s=\mathcal{O}_L$ と取ったものが $\mathfrak{A}_L$ である。$s$ を動かせるようにしたのは、
次に示す有限積の分配則を $s$ の元の個数についての帰納法で示すためである。

- 軌道を 1 つ足した組の全体は、その軌道の上の全単射と残りの組との対に 1 対 1 に対応する
  （$O_0\notin s$ のとき $\mathrm{ins}:\mathfrak{B}_{O_0}\times\mathfrak{A}(s)\to\mathfrak{A}(\{O_0\}\cup s)$ と
  $\mathrm{spl}$ が互いに逆である）。
  必要十分版が示したのは、この一歩が要求するのが添字の相等が判定できることと
  足す添字がもとの集合に属さないことだけであり、成分が全単射であることも、添字が軌道であることも、
  順序 $\prec$ も使っていないことである（成分の型は添字ごとに勝手な型でよい）。
  さらに、**第 2 の等式 $\mathrm{ins}(\mathrm{spl}(\beta))=\beta$ は $O_0\notin s$ すら要求しない**。
  場合分けが $O=O_0$ か否かだけによっているためで、この仮定が要るのは第 1 の等式の側だけである。

さらに、軌道の部分集合にわたる有限積の分配則を示した（四層すべて）。
ここにも $\mathbb{R}/\mathbb{C}$ は現れない。

- $\prod_{O\in s}\bigl(\sum_{\psi\in\mathfrak{B}_O}g(O,\psi)\bigr)
  =\sum_{\alpha\in\mathfrak{A}(s)}\prod_{O\in s}g\bigl(O,\alpha(O)\bigr)$（任意の $s\subset\mathcal{O}_L$）。
  証明は $s$ の元の個数についての帰納法である。出発点は空集合にわたる有限積が $1$ であることと
  $\mathfrak{A}(\emptyset)$ がちょうど 1 元であること、一歩は 8 段の一続きの鎖で、
  有限積から $O_0$ の因子を 1 つ分けて帰納法の仮定を当て、分配則を 2 度使って 2 重の和にし、
  積集合にわたる和へまとめ、$\mathrm{ins}$ の値で項を書き換えてから、
  $\mathrm{ins}$ と $\mathrm{spl}$ が互いに逆であることで和の添字を組へ取り替える。
  $\mathbb{Z}[x][t]$ について使うのは積の結合則と可換性、単位元、および有限和と元の積に
  ついての分配則だけである（引き算も、零因子が無いことも使わない）。
  必要十分版が示したのは、この段が要求するのが「添字の相等が判定できること」
  「各成分の型が有限であること」「値の側が可換半環であること」の 3 つだけであり、
  添字が軌道であることも、成分が全単射であることも、順序 $\prec$ も使っていないことである。
  Lean では、和の添字にするために組の全体の有限性を先に置いた。
  組の全体は命題の上の依存関数型なので `Pi.fintype` が直接は効かず、
  部分型の上の依存関数型との 1 対 1 対応を経由して移してある
  （この経路は添字の型が有限であることを要求しない）。

さらに、この分配則を $\chi_U$ へ当てた（四層すべて）。ここにも $\mathbb{R}/\mathbb{C}$ は現れない。

- $\chi_U=\prod_{O\in\mathcal{O}_L}\bigl(\sum_{\psi\in\mathfrak{B}_{O}}W_{O}(\mathrm{ch}(U),\psi)\bigr)$。
  $2^{L}$ 個の行配位にわたる置換の全体についての和として定義された特性多項式が、
  軌道ごとに閉じた和の積として書けたことになる。証明は 3 段の鎖である
  （前の主張・$\mathfrak{A}(\mathcal{O}_L)=\mathfrak{A}_L$・分配則を $s=\mathcal{O}_L$ と取った段。
  第 3 の等号は分配則を右辺から左辺へ向けて使っている）。
  必要十分版が示したのは、この段が新しく要求するのが**添字の型が有限であることだけ**である
  ことである（部分集合版は $s$ がもとから有限なので添字の型の有限性を要求しなかった）。
  Lean では $\mathfrak{A}(\mathcal{O}_L)$ と $\mathfrak{A}_L$ が同じ型ではない
  （前者は所属の証明を余分に受け取る）ので、行き来する全単射を明示的に置いて
  和の添字を取り替え、積の側は `univ.attach` にわたる積から `univ` にわたる積へ移した。

さらに、巡回シフトが軌道を保つ置換であること（$S\in\mathfrak{S}^{\mathcal{O}}_L$。したがって
制限 $S\!\restriction_{O}$ が定まり $\mathfrak{B}_{O}$ の元である）と、条件を満たす軌道の上の
全単射が 2 つしか無いことを示した。**四層すべてを満たしている**（記述と SageMath 検証は
$L=1,\dots,6$ で通過、Lean 具体版・必要十分版・導出は 2026-08-10）。
ここにも $\mathbb{R}/\mathbb{C}$ は現れない。

- $\psi\in\mathfrak{B}_{O}$ が任意の $\tau\in O$ について $\psi(\tau)=\tau$ または
  $\psi(\tau)=S(\tau)$ を満たすならば、$\psi=\mathrm{id}_{O}$ または $\psi=S\!\restriction_{O}$ である。
  証明は $\psi$ が動かさない行配位の全体 $F=\{\tau\in O\mid\psi(\tau)=\tau\}$ が空か否かで分ける。
  空なら仮定の第 2 の場合だけが残って $\psi=S\!\restriction_{O}$。空でなければ、$F$ が
  1 つ前の行配位について閉じること（$\psi$ の単射性を使う）を見てから、$S^{[e-j]}(\tau_0)\in F$ を
  $j$ についての帰納法で示し、任意の $\tau\in O$ を $\tau=S^{[r]}(\tau_0)$（$r<e$）の形に直して
  $F=O$ を出す。
  必要十分版が示したのは、この 2 主張が **$S$ の単射性も全射性も使っていない**こと
  （全単射性を引いているのは $S\!\restriction_{O}$ を $\mathfrak{B}_{O}$ の元として書くためだけである）、
  および**最小周期の最小性を使っていない**ことである。要るのは $\psi$ の単射性と、
  $O$ の各点が 1 回以上の反復で戻ること・$O$ の 2 点が反復で行き来できること・
  $O$ が反復で閉じていることの 3 つだけである。

さらに、軌道の上の全単射の符号 $\mathrm{sgn}_{O}$ の値について次の 3 つを示した。
**四層すべてを満たしている**（記述と SageMath 検証（$L=1,\dots,6$）は 2026-08-10 の tick 44、
Lean 3 本は同日の tick 45 に `lake build` と sorry 検査を通した）。
ここにも $\mathbb{R}/\mathbb{C}$ は現れない。

- $\mathrm{sgn}_{O}(\psi)$ は $+1$ か $-1$ である。
- $\mathrm{sgn}_{O}(\psi)\cdot\mathrm{sgn}_{O}(\psi)=1$ である。
- $\mathrm{sgn}_{O}(\mathrm{id}_{O})=+1$ である（転倒数の定義に現れる集合が空であることによる。
  三分律のうち「$\tau\prec\tau'$ ならば $\tau'\prec\tau$ でない」だけを使う）。

これは $\mathfrak{S}_L$ の符号について既に示した 3 性質を、台を $P_L$ から $F(O,O)$ へ
取り替えて写したものである。

さらに、軌道の上の互換の反復合成
$\Psi^{O,\tau_0}_{0}=\mathrm{id}_{O}$、$\Psi^{O,\tau_0}_{k+1}=t^{O}_{\tau_0,S^{[k+1]}(\tau_0)}\circ\Psi^{O,\tau_0}_{k}$
を定義し、次を示した。**四層すべてを満たしている**（2026-08-10 の tick 47）。
ここにも $\mathbb{R}/\mathbb{C}$ は現れない。

添字の小さい互換ほど先に作用する。上付きの $O,\tau_0$ は、この写像が軌道と基点の取り方に
依存することを記号に残すためのものである。

- 任意の $k\in\mathbb{N}$ について $\Psi^{O,\tau_0}_{k}\in\mathfrak{B}_{O}$ である。
  証明は $k$ についての帰納法で、準備として「$O$ の上の全単射 2 つの合成は $O$ の上の全単射で
  ある」ことを単射性と全射性を別々に示してから当てる。
  必要十分版が示したのは、この段が要求するのは**各段の写像が全単射であることだけ**であり、
  台が軌道であることも型が有限であることも元の相等が決定できることも順序 $\prec$ も、
  合成する写像が互換であること（2 回合成すると恒等写像であること）さえ使っていないことである。

さらに、最小周期より小さい反復の回数は行く先で見分けられることを示した。
**四層すべてを満たしている**（2026-08-10 の tick 48）。ここにも $\mathbb{R}/\mathbb{C}$ は現れない。

- $a<e(\tau)$、$b<e(\tau)$、$S^{[a]}(\tau)=S^{[b]}(\tau)$ ならば $a=b$ である。
  同じ事実は $\lvert O(\tau)\rvert=e(\tau)$ の証明の中で $\eta_\tau$ の単射性として示してあるが、
  $\eta_\tau$ についての言明の形なので $S^{[k]}$ についての言明としては引けない。
  次の段（巡回シフトの制限が互換の積であること）が各段でこれを使うので、独立した主張として置き直した。
  証明は準備（$a\le b$ の場合の鎖と、$e(\tau)\mid b-a$ かつ $b-a<e(\tau)$ から $b-a=0$ を出す段）と、
  自然数の大小が全順序であることによる 2 つの場合分けである。
  必要十分版が示したのは、この段が要求するのが**述語が対称であることと、$a\le b$ の側で
  結論が出ることの 2 つだけ**であり、行配位も巡回シフトも最小周期も使っていないことである。

さらに、互換の反復合成が基点の反復に与える値を示した。
**四層すべてを満たしている**（2026-08-10 の tick 49）。ここにも $\mathbb{R}/\mathbb{C}$ は現れない。

- $k<e(\tau_0)$ と $r<e(\tau_0)$ のとき、$\Psi^{O,\tau_0}_{k}(S^{[r]}(\tau_0))$ は
  $r<k$ のとき $S^{[r+1]}(\tau_0)$、$r=k$ のとき $\tau_0$、$r>k$ のとき $S^{[r]}(\tau_0)$ である。
  言葉で言えば、$\Psi^{O,\tau_0}_{k}$ は基点から数えて $k$ 番目までの反復を 1 つ先へ送り、
  $k$ 番目を基点へ戻し、それより先の反復を動かさない。
  証明は $k$ についての帰納法で、一歩は $r<k$・$r=k$・$r=k+1$・$r>k+1$ の 4 つの場合に分け、
  各場合で互換の 3 つの場合のどれに入るかを、直前の主張（最小周期より小さい反復の回数は
  行く先で見分けられること）の対偶で判定する。
  必要十分版が示したのは、この段が要求するのが**点の相等が判定できることと、番号が上界より
  小さい範囲で点が相異なること、および反復合成の再帰 2 式だけ**であり、行配位も巡回シフトも
  軌道も最小周期も、写像が全単射であることも、互換が 2 回で恒等写像に戻ることさえ
  使っていないことである。

さらに、巡回シフトの制限が $\lvert O\rvert-1$ 個の互換の合成であることを示した。
**四層すべてを満たしている**（2026-08-10 の tick 50）。ここにも $\mathbb{R}/\mathbb{C}$ は現れない。

- $\Psi^{O,\tau_0}_{\lvert O\rvert-1}=S\!\restriction_{O}$。
  証明は、$O(\tau_0)=O$ から $\lvert O\rvert=e(\tau_0)$ を出し（軌道の元の個数は最小周期に等しい）、
  各点 $\tau\in O$ を $\tau=S^{[r]}(\tau_0)$（$r<e(\tau_0)$）の形へ直してから、
  $r<e(\tau_0)-1$ と $r=e(\tau_0)-1$ の 2 つの場合で、直前の主張（互換の反復合成が
  基点の反復に与える値）に $k=e(\tau_0)-1$ を代入するものである。
  右辺が $\tau_0$ を含まないので、$k=\lvert O\rvert-1$ と取った反復合成は基点の取り方によらない。
  必要十分版が示したのは、この段が要求するのが**一歩の写像が番号を 1 つ進めること・
  $n$ 回で出発点へ戻ること・値の記述・$n\ge1$ の 4 つだけ**であり、行配位も巡回シフトも
  軌道も最小周期も、写像が全単射であることも、互換であることさえ使っていないことである。

さらに、軌道の上の全単射の符号が合成について乗法的であることを示した。
**四層すべてを満たしている**（記述と SageMath 検証は 2026-08-10 の tick 51、
Lean 具体版・必要十分版・導出は tick 52）。ここにも $\mathbb{R}/\mathbb{C}$ は現れない。

- $\mathrm{sgn}_{O}(\psi_1\circ\psi_2)=\mathrm{sgn}_{O}(\psi_1)\cdot\mathrm{sgn}_{O}(\psi_2)$。
  証明は $\mathfrak{S}_L$ の符号の乗法性の議論を、台を $P_L$ から $F(O,O)$ へ取り替えて写したもので、
  $\psi_2$ の像の 2 成分を $\prec$ について並べ直す写像 $\mathrm{srt}_{\psi_2}$ を作り、
  $F(O,O)$ の 3 つの部分集合 $A,B,C$ の個数が 3 つの転倒数に一致することと、
  各対が属するものの個数が偶数であることを見て、$(-1)$ の有限積へ書き換える。
  並べ直しの写像に $\Psi$ を使えない（互換の反復合成に固定してある）ので $\mathrm{srt}$ とした。
  使うのは $\prec$ の三分律だけで、推移律は使っていない。
  Lean の具体版は、置換を `Equiv.Perm` で受けられない（$O$ の上の全単射だから）ので、
  ambient の写像 $g_1,g_2$ と $g_2$ の逆写像 $g_2'$ を受け、$O$ の上での往復が恒等写像で
  あることを仮定する形にした。
  必要十分版が示したのは、姉妹の必要十分版（$\mathfrak{S}_L$ の符号の乗法性）が台を全体から
  作っていて型の有限性を要求していたのに対し、**台を勝手な対の有限集合に取り替えると
  その仮定が落ちる**ことである。要るのは順序についての非対称性と全順序性（三分律をこの 2 つへ
  分けたもの。推移律は要らない）、並べ直しの写像が台の中へ入ることと両向きの往復、および
  台の対で値が相異なることだけであり、写像が全体で単射・全射であることも使っていない。

さらに、互換の反復合成の符号が $(-1)^{k}$ であることを示した。
**四層すべてを満たしている**（2026-08-10 の tick 53）。ここにも $\mathbb{R}/\mathbb{C}$ は現れない。

- $k<e(\tau_0)$ ならば $\mathrm{sgn}_{O}\bigl(\Psi^{O,\tau_0}_{k}\bigr)=(-1)^{k}$ である。
  証明は準備 2 つ（$1\le j<e(\tau_0)$ ならば $\tau_0\ne S^{[j]}(\tau_0)$ であること、および
  $O$ の相異なる 2 点の互換の符号が $-1$ であること）を置いてからの $k$ についての帰納法である。
  準備の第二では $\tau_b\prec\tau_a$ の場合に 2 つの互換が写像として一致すること
  （$t_{\tau_a,\tau_b}=t_{\tau_b,\tau_a}$）を見て、既出の「$\tau_a\prec\tau_b$ のときは $-1$」へ帰着させる。
  上界 $k<e(\tau_0)$ は外せない（$k=e(\tau_0)$ では合成する互換が恒等写像になる）。
  Lean の具体版では、符号が ambient の写像を受けるので反復合成を ambient の写像として持ち直し、
  乗法性が要求する逆写像を、互換の合成の順を逆にした反復合成として置いた。
  必要十分版が示したのは、この段の帰納法が**モノイドしか要求しない**ことである
  （順序も軌道も互換も、値が $\mathbb{Z}$ であることも $u=-1$ であることも積の可換性も使わない）。

さらに、軌道の上の巡回シフトの制限の符号が $(-1)^{\lvert O\rvert-1}$ であることを示した。
**四層すべてを満たしている**（2026-08-10 の tick 54）。ここにも $\mathbb{R}/\mathbb{C}$ は現れない。

- $\mathrm{sgn}_{O}\bigl(S\!\restriction_{O}\bigr)=(-1)^{\lvert O\rvert-1}$ である。
  証明は、$O$ が空でないことから基点 $\tau_0\in O$ を取り、$O=O(\tau_0)$ から
  $\lvert O\rvert=e(\tau_0)$ を出し、$e(\tau_0)\ge1$ と合わせて $\lvert O\rvert-1<e(\tau_0)$ を得てから、
  $\Psi^{O,\tau_0}_{\lvert O\rvert-1}=S\!\restriction_{O}$ と反復合成の符号が $(-1)^{k}$ であることを
  2 段の鎖でつなぐものである。右辺に $\tau_0$ が現れないので、この値は基点の取り方によらない。
  Lean の具体版では、$S\!\restriction_{O}$ を ambient の写像として渡し、写像としての等式を
  $O$ の上での値の一致へ落としてから、符号が $O$ の中の値だけで決まることで符号の等式へ移した。
  必要十分版が示したのは、この段が要求するのが**上界より下で列の値が $u^{k}$ であること・
  着目する元の符号が第 $n-1$ 項の符号に等しいこと・$n=e$・$1\le e$ の 4 つだけ**であり、
  行配位も巡回シフトも軌道も互換も順序も、符号が $(-1)$ の冪であることも、
  元が写像であることさえ使っていないことである。

これで、シフト行列の特性多項式の各軌道の因子に現れる 2 つの項（恒等写像と巡回シフトの制限）の
符号が両方とも決まった。残るのは、各軌道の因子の和が $t^{\lvert O\rvert}-1$ になる段である。

さらに、軌道ごとの和のうち零元でない因子を絞り込む前半を示した。
**四層すべてを満たしている**（2026-08-10 の tick 55）。ここにも $\mathbb{R}/\mathbb{C}$ は現れない。

- $\psi\in\mathfrak{B}_{O}$ について、$\psi(\tau_1)\ne\tau_1$ かつ $\psi(\tau_1)\ne S(\tau_1)$ を
  満たす $\tau_1\in O$ が存在するならば $W_{O}(\mathrm{ch}(U),\psi)=\iota(\kappa(0))$ である。
  証明は 4 段の一続きの鎖（軌道の因子の定義・有限積から $\tau_1$ の因子を括り出す・
  その成分が零元であること・零元を掛けると零元）である。
  台 $R_L$ の上の置換についての同じ主張は既に示してあるが、台が軌道に変わると符号の写像が
  $\mathrm{sgn}$ から $\mathrm{sgn}_{O}$ へ変わるので、別の主張として置き直した。
  必要十分版が示したのは、姉妹の言明（台が全体、$\varphi$ が置換）と比べて
  **台を勝手な有限集合に、写像を勝手な写像に取り替えると、添字の型の有限性と全単射性の仮定が
  落ちる**ことである。すなわちこの段は軌道であることも $\psi$ が全単射であることも使っていない。

さらに、軌道の元が巡回シフトで動かないことと、その軌道の元の個数が 1 であることが
同値であることを示した。**四層すべてを満たしている**（2026-08-10 の tick 56）。
ここにも $\mathbb{R}/\mathbb{C}$ は現れない。

- $O\in\mathcal{O}_L$ と $\tau\in O$ について、$S(\tau)=\tau\iff\lvert O\rvert=1$ である。
  これが要るのは、シフト行列の特性行列の対角成分 $\mathrm{ch}(U)_{\tau,\tau}$ の場合分けが
  $\tau=S(\tau)$ か否かによっており、それを軌道の元の個数で判定したいからである。
  証明は準備 2 つ（$\lvert O\rvert=\lvert O(\tau)\rvert=e(\tau)$ と $S^{[1]}(\tau)=S(\tau)$）を
  置いてからの両向きで、$e(\tau)$ が $1$ を割り切ることから $e(\tau)=1$ を出す段は
  $1=e(\tau)q$ の $q\ge1$ と $e(\tau)\ge2$ の矛盾で書いた。
  必要十分版が示したのは、この段が要求するのが**反復の第 1 項が一歩の写像に一致すること・
  周期が倍数を特徴づけること・周期が 1 以上であることの 3 つだけ**であり、軌道であることも、
  写像が巡回シフトであることも全単射であることも、反復の再帰 2 式も、型の有限性も、
  順序 $\prec$ も、「軌道の元の個数」という数え上げそのものも使っていないことである。

さらに、シフト行列の特性行列の対角成分がその軌道の元の個数で決まることを示した。
**四層すべてを満たしている**（2026-08-10 の tick 57）。ここにも $\mathbb{R}/\mathbb{C}$ は現れない。

- $O\in\mathcal{O}_L$ と $\tau\in O$ について、$\lvert O\rvert\ge2$ ならば
  $\mathrm{ch}(U)_{\tau,\tau}=t$、$\lvert O\rvert=1$ ならば
  $\mathrm{ch}(U)_{\tau,\tau}=t+\iota(-\kappa(1))$ である。
  証明は準備（$\mathrm{ch}(U)_{\tau,\tau}=t+\iota(-U_{\tau,\tau})$）を置いてからの 2 つの場合で、
  第一の場合は直前の同値の対偶で $S(\tau)\ne\tau$ を出して $U_{\tau,\tau}=\kappa(0)$ を代入し、
  第二の場合は同値を右辺から左辺へ用いて $U_{\tau,\tau}=\kappa(1)$ を代入する。
  $\tau\in O$ より $\lvert O\rvert\ge1$ なので 2 つの場合は尽くされている。
  必要十分版が示したのは、この段が要求するのが**場合分けの条件の同値・2 つの場合の成分の値・
  零元を送ると目的の値になることの 3 つだけ**であり、値の側の代数構造も、軌道であることも、
  写像が巡回シフトであることも、型の有限性も、順序 $\prec$ も、
  「軌道の元の個数」という数え上げそのものも使っていないことである。

さらに、恒等写像の因子がその軌道の元の個数で決まることを示した。
**四層すべてを満たしている**（2026-08-10 の tick 58）。ここにも $\mathbb{R}/\mathbb{C}$ は現れない。

- $O\in\mathcal{O}_L$ について、$\lvert O\rvert\ge2$ ならば
  $W_{O}(\mathrm{ch}(U),\mathrm{id}_{O})=t^{\lvert O\rvert}$、$\lvert O\rvert=1$ ならば
  $W_{O}(\mathrm{ch}(U),\mathrm{id}_{O})=t+\iota(-\kappa(1))$ である。
  証明は、まず両方の場合に共通する 4 段（軌道の因子の定義・$\mathrm{sgn}_{O}(\mathrm{id}_{O})=+1$・
  恒等写像の値・$\iota(\kappa(1))$ が単位元であること）で因子を対角成分の有限積へ落とし、
  そのあと 2 つの場合に分ける。$\lvert O\rvert\ge2$ では対角成分がすべて $t$ なので積は
  $t^{\lvert O\rvert}$、$\lvert O\rvert=1$ では $O$ が 1 元集合なので積は 1 つの因子である。
  必要十分版が示したのは、この段が要求するのが**重みが単位元であること・台の上で因子がすべて
  等しいこと（第一の場合）・台が 1 元集合であること（第二の場合）の 3 つだけ**であり、
  行配位も軌道も順序 $\prec$ も型の有限性も、値が多項式であることも符号が $\pm1$ であることも
  使っていないこと（可換モノイドで足りる）である。

さらに、軌道の元の個数が 2 以上のとき、巡回シフトの制限の因子が単位元の加法についての
逆元であることを示した。**四層すべてを満たしている**（2026-08-10 の tick 59）。
ここにも $\mathbb{R}/\mathbb{C}$ は現れない。

- $O\in\mathcal{O}_L$ について、$\lvert O\rvert\ge2$ ならば
  $W_{O}\bigl(\mathrm{ch}(U),S\!\restriction_{O}\bigr)=\iota(-\kappa(1))$ である。
  $u:=\iota(-\kappa(1))$ と置き、準備を 4 つ（$S\!\restriction_{O}\in\mathfrak{B}_{O}$、
  $\iota(\kappa(-1))=u$、任意の $\tau\in O$ について $\mathrm{ch}(U)_{\tau,S(\tau)}=u$、
  $u\cdot u=\iota(\kappa(1))$ が単位元であること）置いてからの 12 段の一続きの鎖である。
  符号 $(-1)^{\lvert O\rvert-1}$ を代入し、成分をすべて $u$ へ書き換えて積を $u^{\lvert O\rvert}$ へ
  畳み、指数を足して $2(\lvert O\rvert-1)+1$ の形へ直し、$u\cdot u=1$ で二乗を落とす。
  $\lvert O\rvert=1$ を仮定から外してあるのは、その場合に $S\!\restriction_{O}$ が
  $\mathrm{id}_{O}$ と写像として一致し、値が $t+\iota(-\kappa(1))$ になるためである。
  必要十分版が示したのは、この段が要求するのが**重みが $u^{\lvert O\rvert-1}$ であること・
  台の上で因子がすべて $u$ であること・$u\cdot u=1$・$1\le\lvert O\rvert$ の 4 つだけ**であり、
  行配位も軌道も順序 $\prec$ も型の有限性も、$u$ が $\iota(-\kappa(1))$ であることも
  （$-1$ であることも、加法や零元があることも）使っていないことである。

これで、シフト行列の特性多項式の軌道ごとの因子に残る 2 項の値が両方とも決まった。
残るのは、この 2 項を足して $t^{\lvert O\rvert}-1$ を出す段である。

さらに、倍数を指数とする冪と単位元の逆元との和が、約数を指数とするそれと冪の有限和との
積であることを示した。**四層すべてを満たしている**（2026-08-10 の tick 61）。
ここにも $\mathbb{R}/\mathbb{C}$ は現れない（$\mathbb{Z}[x][t]$ の中の等式である）。

- 任意の $d\in\mathbb{N}$ と $k\in\mathbb{N}$ について
  $t^{dk}+\iota(-\kappa(1))=\bigl(t^{d}+\iota(-\kappa(1))\bigr)\cdot\sum_{j<k}t^{dj}$ である。
  通常 $t^{dk}-1=(t^{d}-1)(1+t^{d}+\dots+t^{d(k-1)})$ と書かれる等式を、$\mathbb{Z}[x][t]$ の
  引き算を使わずに書いたものである（$u:=\iota(-\kappa(1))$ は単位元の加法についての逆元）。
  証明は準備 2 つ（単位元と零元の確認、$\iota(\kappa(1))+u=\iota(\kappa(0))$）を置いてからの
  $k$ についての帰納法で、出発点は $k=0$（両辺がともに零元）、一歩は 11 段の一続きの鎖である。
  **仮定に $d\ge1$・$k\ge1$ を置いていない。** 出発点を $k=0$ に置けるので退化した場合を
  除く必要がなく、使わない仮定を書かないためである。
  必要十分版が示したのは、この段が要求するのが**半環と $1+u=0$ の 2 つだけ**であり、
  $a$ が $t^{d}$ の形であること（$d$ そのものが消える）も、値が多項式であることも、
  積の可換性も、加法の逆元の存在も使っていないことである。

これを軌道の元の個数が格子の一辺を割り切ることと合わせると、軌道ごとの因子
$t^{\lvert O\rvert}+\iota(-\kappa(1))$ が $t^{L}+\iota(-\kappa(1))$ を割ることが
$\mathbb{Z}[x][t]$ の中で言える。それが次のセクションである。

さらに、シフト行列の特性多項式の値を 0 にする代数的数が 1 の $L$ 乗根であることを示した。
**四層すべてを満たしている**（2026-08-10 の tick 70）。
ここにも $\mathbb{R}/\mathbb{C}$ は現れない（$\overline{\mathbb{Q}}$ は可算集合である）。

- $\mathrm{ev}_{\xi,z}(\chi_U)=0$ ならば $z\in\mu_{L}$ である。
  すなわち、シフト行列の固有値として現れうる代数的数は 1 の $L$ 乗根に限られる。
  証明は 3 段の鎖（仮定・$\chi_U$ が軌道ごとの因子の積であること・値を取る写像が有限積を
  有限積へ写すこと）で $0=\prod_{O}\mathrm{ev}_{\xi,z}(t^{\lvert O\rvert}+u)$ を出し、
  値が 0 である因子 $O_0$ を取り、その因子の根が 1 の $\lvert O_0\rvert$ 乗根であることと
  $\lvert O_0\rvert=e(\tau_0)$・$e(\tau_0)\mid L$ から $\mu_{\lvert O_0\rvert}\subset\mu_{L}$ で移す。
  必要十分版が示したのは、この段が**組み立てだけ**であり、要求するのが
  「写像が有限積を有限積へ写すこと」「値の側が可換群に零元を添えた構造であること」
  「各因子から所属が出ること」「各指数が $L$ を割ること」「所属先が整除で単調であること」の
  5 つだけで、多項式であることも特性多項式であることも軌道であることも順序 $\prec$ も
  使っていないことである。

これで章「固有値の代数性」のシフト行列の側（$\chi_U$ の根の同定）が閉じた。
次は転送行列をシフト行列の固有空間へ分ける段である。


さらに、代数的数を成分とする列ベクトルの和 $v\oplus w$ とスカラー倍 $z\odot v$ を定義し、
行列の作用がその 2 つを保つことを示した。**四層すべてを満たしている**（2026-08-10 の tick 72）。
ここにも $\mathbb{R}/\mathbb{C}$ は現れない。

記号 $\oplus,\odot$ は、$\overline{\mathbb{Q}}$ の加法・乗法と区別するために分けて書く。

- $A\cdot(v\oplus w)=(A\cdot v)\oplus(A\cdot w)$（6 段の鎖）。
- $A\cdot(z\odot v)=z\odot(A\cdot v)$（8 段の鎖）。
  必要十分版が示したのは、**2 つの主張で要る性質が違う**ことである。
  和を保つことは添字の型が有限であることと値の側が非単位的・非結合的半環であることしか
  要求せず、**積の可換性も結合則も使っていない**。スカラー倍を保つことだけが積の可換性を
  要求する（$z$ を成分の左へ移す段）。SageMath でも、成分を非可換環（2 次上三角行列）に
  取ると和の側は成り立ち、スカラー倍の側は実際に破れることを確かめた。

さらに、零ベクトル $o_L$、固有ベクトル（$A\cdot v=z\odot v$ かつ $v\ne o_L$）、固有値、
および固有空間 $E_A(z)=\{v\in V_L\mid A\cdot v=z\odot v\}$ を定義し、次の 2 つを示した。
**四層すべてを満たしている**（2026-08-10 の tick 73）。ここにも $\mathbb{R}/\mathbb{C}$ は現れない。

固有空間の条件から $v\ne o_L$ を外してある。外さないとスカラー倍で閉じない
（$v$ が条件を満たすとき $0\odot v=o_L$ も満たす）ためで、理由は本文に書いてある。

- 固有空間は和で閉じる（$v,w\in E_A(z)$ ならば $v\oplus w\in E_A(z)$）。証明は 7 段の鎖である。
- 固有空間はスカラー倍で閉じる（$v\in E_A(z)$ ならば $c\odot v\in E_A(z)$）。証明は 9 段の鎖である。
  必要十分版が示したのは、**値の型にも列ベクトルの型にも代数構造を一切要求しない**ことである
  （作用は勝手な写像 $V\to V$ でよく、半環も有限和も添字の有限性も要らない）。
  和で閉じることが要るのは「作用が和を保つこと」と「スカラー倍が和へ配ること」の 2 つ、
  スカラー倍で閉じることが要るのは「作用がスカラー倍を保つこと」と「2 つのスカラー倍が
  交換できること」の 2 つだけである。後者が具体版では積の可換性にあたり、そこが 2 つの主張の差である。


さらに、代数的数の冪の差がもとの 2 元の差を因子に持つことを示した。
**四層すべてを満たしている**（2026-08-11 の tick 101）。ここにも $\mathbb{R}/\mathbb{C}$ は現れない。

$H_{n}(z,w)$ は閉じた形の和ではなく約束（$H_{0}(z,w)=0$、$H_{n+1}(z,w)=H_{n}(z,w)\,w+z^{n}$）で定めた。

- $(z-w)\,H_{n}(z,w)=z^{n}-w^{n}$。証明は $n$ についての帰納法 1 本で、
  出発点 5 段・一歩 11 段の一続きの鎖である。$w=1$ と取ると伸縮の等式に一致するので、
  これはその 2 元への一般化である。
  必要十分版が示したのは、要求されるのが**環の可換性ではなく、この 2 元が可換であることだけ**である
  ことである（11 段のうち可換則を使うのは $w\,z^{n}=z^{n}w$ の 1 段だけで、そこだけを
  仮定として受け取れば非可換環でも同じ鎖で通る）。SageMath 側では、2 次整数行列環の
  可換でない 2 元では等式が実際に破れることを確かめ、仮定が削れないことを裏取りした。
  これは $\mu_n$ がちょうど $n$ 個の元を持つことを示すための足場であり、
  「根 $w$ を持つ多項式が $(t-w)$ を因子に持つこと」を与える等式である。

さらに、$\overline{\mathbb{Q}}$ を係数とする 1 変数多項式環 $\overline{\mathbb{Q}}[t]$
（係数 $\mathrm{ac}_k$・定数として送る写像 $\widehat{\,\cdot\,}$・冪の約束）を置き、
因数定理へ向かう次の段を進めた（いずれも四層すべて。tick 102〜106）。
ここにも $\mathbb{R}/\mathbb{C}$ は現れない。

- $(t-\widehat{w})K_{n}(w)=t^{\,n}-\widehat{w}^{\,n}$（tick 102。$\overline{\mathbb{Q}}$ の版と同じ鎖）。
- $\mathrm{ac}_j(t^{\,k})$ は $j=k$ のとき 1、そうでなければ 0（tick 103）。
- 代入 $\mathrm{aev}_w$ の定義と、$k>n$ で係数が零なら
  $f=\sum_{k=0}^{n}\widehat{\mathrm{ac}_k(f)}\,t^{\,k}$（tick 105。係数の突き合わせ 1 本）。
- $\widehat{w^{\,n}}=\widehat{w}^{\,n}$（tick 106。左右の冪は住む環が違う別々の約束なので、
  約束からは出ない主張である。必要十分版が示したのは、要るのが両側の冪の約束と写像が単位元と
  積を保つことだけで、**積の結合則すら使わない**こと。`Monoid` を仮定せず
  `One`/`Mul`/`Pow _ ℕ` の記号と約束の仮定だけで書いた）。
- $\mathrm{aev}_{w}(t^{\,n})=w^{\,n}$（tick 107。帰納法の出発点 3 段・一歩 5 段。
  必要十分版は直前の段と同じ定理を共有し、代入写像へ特殊化した）。

## 進め方（自動ループ）

このプロジェクトは **1 時間に 1 回の自動ループ**で進む。手順の正本は
[docs/tasks/auto-loop-runbook.md](docs/tasks/auto-loop-runbook.md)、進捗の正本は
[docs/tasks/auto-loop-state.md](docs/tasks/auto-loop-state.md) である（このファイルではない）。

- 1 tick = 既存出力のレビューと修正 → セクションを **1 つだけ** 前進 → 検証 → push → 停止。
- 各 tick は launchd（`com.masaori.ising-lambda-auto-loop`）が起動する
  **独立した Claude セッション**で走る。会話の文脈は持ち越さない。
- 次に何をするかは、下の「次回やること」ではなく**状態台帳のセクション表**を見る。

## 次回やること

- **レビュー**: 「ブロック敷き詰め評価の対数化」の本文・SageMath・Lean（具体版・必要十分版・導出版）を
  突き合わせる。特に補正項の有理数係数 $2(k-1)/(ka)$ の Lean 側の表現（$k-1$ は ℕ の減法）が
  本文と一致しているか。
- **次に進めるセクションは「倍数の辺での下限への任意近接（$0<t\le1$ の場合）」**（状態台帳のセクション表の先頭行）。
- **並列の作業ストリーム（式変形の書き方の統一）を毎 tick 1 件進める**。
  姉妹側「偶セクターの転送行列の共役作用」（`014_even_sector_T_action`）の「$\check Z$ の $n$ 重交換子」の
  帰納段階以降から、根拠なし・複数関係の計算を機械走査で特定する。
- **push の直前に `lake build` を回す。**

## 前の tick の記録（1 つ前）

**2026-08-11 の tick 94 は、レビューで直すところが無く、セクション 10h3d-c2
（1 の冪根の全体 $\mu_n$ が積で閉じていること）を四層すべてで完了させた。**
主張は $\mu_L$ ではなく一般の $n$ について述べた（証明が $n$ の値を一切使わないため）。

1. **レビュー**: 今 tick で書いた本文 1 ブロック（`claim_root_of_unity_mul`）と
   Lean 3 本（`RootOfUnityMul` 系）と SageMath の `root-of-unity-mul`。
   とくに、主張を $L$ ではなく一般の $n$ で述べたことが本文の他の箇所（この主張を使う先が
   $\mu_L$ であること）と食い違っていないか、必要十分版が「1 の冪根であることを使っていない」
   と述べていることが具体版の鎖と突き合わせて正しいかを見る。
2. **次に進めるセクションは 10h3d-c3**（$\mu_L$ の元を掛ける操作が $\mu_L$ から $\mu_L$ への
   全単射であること）。状態台帳のセクション表が正本である。**着手前に、逆写像を
   $z^{-1}$ を掛ける操作ではなく $w^{L-1}$ を掛ける操作として書けるかを確かめる**
   （逆元を使わずに済ませられれば、必要十分版の仮定をモノイドのままに保てる。
   落とす写像のところで $z^{-k}$ を避けて $z^{L-k}$ と書いたのと同じ判断である）。
   なお今 tick の主張が一般の $n$ で書けたのに対し、この段は $w^{L}=1$ を実際に使うので
   $\mu_L$ の $L$ が効く。どこから $L$ が要るのかを本文に書くこと。
3. **並列の作業ストリーム（式変形の書き方の統一）を毎 tick 1 件進める**
   （台帳の「式変形の書き方の統一」の表が正本）。
4. **push の直前に `lake build` を回す。** tick 90 は Lean を書いたあと再ビルドせずに
   台帳へ「通した」と書き、`origin/main` の Lean が落ちる状態で残っていた（tick 91 で修理した）。

## 前の tick の記録

**2026-08-10 の tick 60 は、レビューでは直すところが無く、セクション 10f'''c3c2
（軌道ごとの和が $t^{\lvert O\rvert}-1$ であること。2 項を足し合わせる段）を
四層すべてで完了させた。** これでシフト行列の特性多項式の軌道ごとの因子の値が決まり、
$\chi_U=\prod_{O}\bigl(t^{\lvert O\rvert}+\iota(-\kappa(1))\bigr)$ になった。

1. **レビュー**: 今 tick で書いた本文 1 ブロック（`claim_orbit_sum_two_terms`）と
   Lean 9 本（`OrbitSumTwoTerms` 系。具体版 5・必要十分版 3・導出 1）。とくに、
   本文が $\lvert O\rvert=1$ の場合も同じ式に収まることを主張の欄で述べていること
   （前 2 セクションでは 2 つの場合の値が違ったのに、和にすると一致する）が
   読み手に正しく伝わる書き方かと、必要十分版が 2 つの場合を別の定理に分けていること
   （分ける理由が軌道の元の個数ではなく $a=b$ になるか否かであること）が
   必要十分性の見極めとして適切かを見る。
2. **並列の作業ストリーム（式変形の書き方の統一）は今 tick も行った**（姉妹プロジェクトの
   「零行列の exp は単位行列である」で、根拠の無かった 5 行の鎖を 8 行へ分けた。
   これで `003_exp_linear_map` は全 5 件が済んだ）。次 tick も 1 件進める
   （次のファイルは `004_transfer_matrix`、9 件ある）。
3. そのあとセクション 10g（特性多項式の根が 1 の $L$ 乗根であること。
   ここで $\overline{\mathbb{Q}}$ へ入る）。軌道ごとの因子が $t^{\lvert O\rvert}-1$ に
   決まったので、$\chi_U$ が $t^{L}-1$ の冪を割ることが $\mathbb{Z}[t]$ の中で言える。

### 前の tick の記録

**2026-08-10 の tick 59 は、レビューでは直すところが無く、セクション 10f'''c3c を
10f'''c3c1・10f'''c3c2 の 2 つへ割り直して、その最初（軌道の元の個数が 2 以上のとき、
巡回シフトの制限の因子が単位元の加法についての逆元であること）を四層すべてで完了させた。**

1. **レビュー**: 今 tick で書いた本文 1 ブロック（`claim_orbit_shift_restriction_factor`）と
   Lean 3 本（`OrbitShiftRestrictionFactor` 系）。とくに、本文が主張から
   $\lvert O\rvert=1$ を外している理由を主張の欄で述べていること（外さないと
   `claim_orbit_identity_factor` の第二の場合と食い違う）が、読み手に正しく伝わる書き方かと、
   必要十分版が $u$ について $u\cdot u=1$ しか要求しない形（符号であることも $-1$ であることも
   使わない）が、必要十分性の見極めとして適切かを見る。
2. **並列の作業ストリーム（式変形の書き方の統一）も 1 件進める**
   （姉妹プロジェクトの `003_exp_linear_map` の残り）。
3. そのあと 10f'''c3c2（軌道ごとの和が $t^{\lvert O\rvert}-1$ であること。
   2 項を足し合わせる段。$\lvert O\rvert=1$ では 2 項が同じ写像なので和は 1 項になる）。
4. そのあと、その根が 1 の $L$ 乗根であること（セクション 10g。ここで $\overline{\mathbb{Q}}$ へ入る）。

### 前の tick の記録

**2026-08-10 の tick 58 は、レビューでは直すところが無く、セクション 10f'''c3b2b
（恒等写像の因子が軌道の元の個数で決まること）を四層すべてで完了させた。**

1. **レビュー**: 今 tick で書いた本文 1 ブロック（`claim_orbit_identity_factor`）と
   Lean 6 本（`OrbitIdentityFactor` 系。具体版 2・必要十分版 2・導出 2）。とくに、
   必要十分版が可換モノイドの有限積についての言明にまで薄まっていることが、
   必要十分性の見極めとして適切か（この段が実際に薄いのか、それとも見落としがあるのか）を見る。
   あわせて、本文が 2 つの場合を 1 つの主張に入れたこと（前のセクションの対角成分の
   2 つの場合をそのまま引き継いだ形）が読みづらくないかを見る。
2. **並列の作業ストリーム（式変形の書き方の統一）は今 tick も行った**（姉妹プロジェクトの
   「exp 級数の各点収束」で、1 行に 2 つ以上の関係を並べていた 8 箇所を 1 行 1 関係の鎖へ分けた）。
   次 tick も 1 件進める（`003_exp_linear_map` の残り 2 件）。
3. そのあと 10f'''c3c（巡回シフトの制限の因子が $-1$ であることと、軌道ごとの和が
   $t^{\lvert O\rvert}-1$ であること）。$\lvert O\rvert=1$ では 2 項が同じ写像になるので
   和は 1 項（$t-1$）になることに注意する。
4. そのあと、その根が 1 の $L$ 乗根であること（セクション 10g。ここで $\overline{\mathbb{Q}}$ へ入る）。

### 前の tick の記録

**2026-08-10 の tick 57 は、レビューでは直すところが無く、セクション 10f'''c3b2 を
10f'''c3b2a・10f'''c3b2b の 2 つへ割り直して、その最初（シフト行列の特性行列の対角成分が
その軌道の元の個数で決まること）を四層すべてで完了させた。**

1. **レビュー**: 今 tick で書いた本文 1 ブロック（`claim_shift_char_diagonal_entry`）と
   Lean 6 本（`ShiftCharDiagonalEntry` 系。具体版 2・必要十分版 2・導出 2）。とくに、
   必要十分版が代数構造を一切要求しない形（`t + ι(-κ(0)) = t` を仮定として受け取る）に
   なっていることが、必要十分性の見極めとして適切か（受け取りすぎて中身が空になっていないか）を見る。
2. **並列の作業ストリーム（式変形の書き方の統一）は今 tick も行った**（姉妹プロジェクトの
   「行列の exp 級数はノルム収束する」で、1 行に 2 つ以上の関係を並べていた 4 箇所を
   1 行 1 関係の鎖へ分けた）。次 tick も 1 件進める（`003_exp_linear_map` の残り 3 件）。
3. そのあと 10f'''c3b2b（恒等写像の因子が $t^{\lvert O\rvert}$ であること。対角成分の積を取る段）、
   10f'''c3c（巡回シフトの制限の因子が $-1$ であることと、和が $t^{\lvert O\rvert}-1$ であること）。
4. そのあと、その根が 1 の $L$ 乗根であること（セクション 10g。ここで $\overline{\mathbb{Q}}$ へ入る）。

### 前の tick の記録

**2026-08-10 の tick 56 は、レビューで 1 件（3 つの主張の見出しに数式記法が素の文字として
書かれていたのを言葉へ直した）を直したうえで、セクション 10f'''c3b を 2 つへ割り直して、
その最初（軌道の元が巡回シフトで動かないことと、軌道の元の個数が 1 であることの同値）を
四層すべてで完了させた。**

1. **レビュー**: 今 tick で書いた本文 1 ブロック（`claim_orbit_fixed_iff_card_one`）と
   Lean 3 本（`OrbitFixedIffCardOne` 系）。とくに、本文が $e(\tau)\mid1\Rightarrow e(\tau)=1$ を
   自然数の議論として書き下していること（`Nat.dvd_one` へ委ねないための書き方が
   冗長になっていないか）と、必要十分版が周期を「勝手な自然数 $e$」として受け取る形にしていて
   最小性を一切使っていないことが、必要十分性の見極めとして適切かを見る。
2. **並列の作業ストリーム（式変形の書き方の統一）を 1 件進める**（姉妹プロジェクトの
   次のファイルは `003_exp_linear_map`）。
3. そのあと 10f'''c3b2（恒等写像の因子が $t^{\lvert O\rvert}$ であること）、
   10f'''c3c（巡回シフトの制限の因子が $-1$ であることと、和が $t^{\lvert O\rvert}-1$ であること）。
4. そのあと、その根が 1 の $L$ 乗根であること（セクション 10g。ここで $\overline{\mathbb{Q}}$ へ入る）。

**2026-08-10 の tick 55 は、レビューでは直すところが無く、セクション 10f'''c3 を 3 つへ
割り直して、その最初（行の添字にもその像にも当たらない値を取る軌道の上の全単射の因子は
零元であること）を四層すべてで完了させた。**

1. **レビュー**: 本文 1 ブロック（`claim_orbit_factor_zero`）と
   Lean 3 本（`OrbitFactorZero` 系）。とくに、既出の `claim_shift_char_term_zero` と
   議論がほぼ同じであることを本文が明示している書き方（別の主張として置き直した理由を
   主張の欄に書いている）が適切かと、必要十分版が姉妹の言明との差分（型の有限性と
   全単射性が落ちること）をコメントで述べるにとどめていて、その差分自体を検査する仕掛けが
   要らないかを見る。
2. **並列の作業ストリーム（式変形の書き方の統一）は今 tick も行った**（姉妹プロジェクトの
   「$\mathrm{Mat}(n,K)$ の完備性と絶対収束判定」で、1 行に 2 つ以上の関係を並べていた
   3 箇所を 1 行 1 関係の鎖へ分けた。これで `002_linear_space_general` は全 12 件が済み）。
   次 tick も 1 件進める（次のファイルは `003_exp_linear_map`）。
3. そのあと 10f'''c3b（恒等写像の因子が $t^{\lvert O\rvert}$ であること）、
   10f'''c3c（巡回シフトの制限の因子が $-1$ であることと、和が $t^{\lvert O\rvert}-1$ であること）。
4. そのあと、その根が 1 の $L$ 乗根であること（セクション 10g。ここで $\overline{\mathbb{Q}}$ へ入る）。

**2026-08-10 の tick 54 は、レビューでは直すところが無く、セクション 10f'''c2d2b
（軌道の上の巡回シフトの制限の符号が $(-1)^{\lvert O\rvert-1}$ であること）を
四層すべてで完了させた。**

**2026-08-10 の tick 53 は、レビューで 2 件（Lean の導出のファイル冒頭が必要十分版の仮定の個数を
6 と書いていたのを 8 へ訂正、および台帳の「現在地」が 2 tick ぶん止まっていたのを追記）を
直したうえで、セクション 10f'''c2d2 を 2 つへ割り直し、その最初（互換の反復合成の符号が
$(-1)^{k}$ であること）を四層すべてで完了させた。**

1. **レビュー**: 今 tick で書いた本文 1 ブロック（`claim_orbit_transposition_composite_sign`）と
   Lean 3 本（`OrbitTranspositionCompositeSign` 系）。とくに、具体版が反復合成を ambient の
   写像として持ち直している点（人手証明の $\Psi^{O,\tau_0}_{k}$ との対応が
   `ambientComposite_val` で足りているか）と、必要十分版が符号についての言明ですらない
   一般の列についての言明になっている点が、必要十分性の見極めとして適切かを見る。
2. **並列の作業ストリーム（式変形の書き方の統一）は今 tick も行った**（姉妹プロジェクトの
   「行列乗算の連続性」の 3 段の鎖に、行ごとの根拠を置いた）。次 tick も 1 件進める。
3. そのあと 10f'''c2d2b（$\mathrm{sgn}_{O}(S\!\restriction_{O})=(-1)^{\lvert O\rvert-1}$。
   $\Psi^{O,\tau_0}_{\lvert O\rvert-1}=S\!\restriction_{O}$ と今 tick の等式に
   $k=\lvert O\rvert-1$ を代入する）。
4. そのあと、各軌道の因子の和が $t^{\lvert O\rvert}-1$ であること（10f'''c3）。
5. そのあと、その根が 1 の $L$ 乗根であること（セクション 10g。ここで $\overline{\mathbb{Q}}$ へ入る）。

**2026-08-10 の tick 52 は、レビューでは直すところが無く、前 tick が残した Lean 3 本を書いて
セクション 10f'''c2d1（軌道の上の全単射の符号が合成について乗法的であること）を
四層すべてで完了させた。**

1. **レビュー**: tick 52 で書いた Lean 3 本（`OrbitPermutationSignMul` 系）。とくに、
   具体版が $O$ の上の全単射を ambient の写像と逆写像の組で受けている点（人手証明の
   $\psi_1,\psi_2\in\mathfrak{B}_{O}$ との対応が対応表で読めるか）と、必要十分版の仮定 8 つが
   すべて具体版の証明で実際に使われているかを見る。
2. **並列の作業ストリーム（式変形の書き方の統一）を 1 件進める。**
3. そのあと 10f'''c2d2（符号が $(-1)^{\lvert O\rvert-1}$）。反復合成 $\Psi^{O,\tau_0}_{k}$ への
   $k$ についての帰納法で $\mathrm{sgn}_{O}(\Psi_k)=(-1)^k$ を出し、$k=\lvert O\rvert-1$ と取る。
4. そのあと、各軌道の因子の和が $t^{\lvert O\rvert}-1$ であること（10f'''c3）。
5. そのあと、その根が 1 の $L$ 乗根であること（セクション 10g。ここで $\overline{\mathbb{Q}}$ へ入る）。

**2026-08-10 の tick 51 は、レビューでは直すところが無く、セクション 10f'''c2d を
10f'''c2d1・10f'''c2d2 の 2 つへ割り直して、その最初（軌道の上の全単射の符号が合成について
乗法的であること）を記述と SageMath 検証まで進めた。Lean 3 本は未着手である。**

1. **まず 10f'''c2d1 の Lean を書いて `done` にする**（具体版・必要十分版・導出）。
   本文ブロック `claim_orbit_permutation_sign_mul` の `lean` の欄が空のままなので、
   書いたら埋めること。具体版は `AlgebraicEigenvalue/PermutationSign.lean` の
   `permSign_comp` を、台を `orderedPairs` から `crossOrderedPairs O O` へ取り替えて写す。
   必要十分版は既存の `NecSuf/.../PermutationSign.lean` が `Fintype α` の univ を台に
   していて直接は使えない（台を任意の対の有限集合にする一般化が要るかを最初に判断する）。
2. **レビュー**: 今 tick で書いた本文 1 ブロック（`claim_orbit_permutation_sign_mul`）と
   SageMath 検証 `orbit-permutation-sign-mul`。とくに、$C$ の定義が
   $\mathrm{srt}_{\psi_2}$ による逆像であることの説明が式と合っているかと、
   $L=6$ で組を絞ったことが overview.md に正しく書けているかを見る。
3. **並列の作業ストリーム（式変形の書き方の統一）は今 tick も行った**（姉妹プロジェクトの
   「行列ノルムの劣乗法性」で、平方以降の 3 つの式の間に日本語を挟んでいたところを
   1 行 1 関係の鎖へまとめた）。次 tick も 1 件進める。
4. そのあと 10f'''c2d2（符号が $(-1)^{\lvert O\rvert-1}$）。
5. そのあと、各軌道の因子の和が $t^{\lvert O\rvert}-1$ であること（10f'''c3）。
6. そのあと、その根が 1 の $L$ 乗根であること（セクション 10g。ここで $\overline{\mathbb{Q}}$ へ入る）。

**2026-08-10 の tick 50 は、レビューでは直すところが無く、セクション 10f'''c2c2c
（巡回シフトの制限が $\lvert O\rvert-1$ 個の互換の合成であること）を四層すべてで完了させた。**

1. **レビュー**: 今 tick で書いた本文 1 ブロック
   （`claim_orbit_transposition_composite_is_shift`）と Lean 3 本
   （`OrbitTranspositionCompositeIsShift` 系）。とくに、主張の欄の「$k=\lvert O\rvert-1$ と
   取ったものは基点によらない」という段が主張なのか観察なのかが曖昧でないかと、
   Lean の具体版が `k % e` を取っていて人手証明の自然数の除法と書き方が違う点
   （対応表に説明が無い）を見る。
2. **並列の作業ストリーム（式変形の書き方の統一）は今 tick も行った**（姉妹プロジェクトの
   「ノルムの基本性質」で、1 行に 2 つ以上の関係を並べていた 8 か所を 1 行 1 関係の鎖へ分けた）。
   次 tick も 1 件進める。
3. そのあと 10f'''c2d（符号が $(-1)^{\lvert O\rvert-1}$）。
4. そのあと、各軌道の因子の和が $t^{\lvert O\rvert}-1$ であること（10f'''c3）。
5. そのあと、その根が 1 の $L$ 乗根であること（セクション 10g。ここで $\overline{\mathbb{Q}}$ へ入る）。

**2026-08-10 の tick 49 は、レビューでは直すところが無く、セクション 10f'''c2c2 を
10f'''c2c2b・10f'''c2c2c の 2 つへ割り直して、その最初（互換の反復合成が基点の反復に与える値）を
四層すべてで完了させた。**

1. **レビュー**: 今 tick で書いた本文 1 ブロック
   （`claim_orbit_transposition_composite_values`）と Lean 3 本
   （`OrbitTranspositionCompositeValues` 系）。とくに、4 つの場合が尽くされていることの根拠を
   地の文で述べるにとどめている点と、必要十分版が反復合成を構成せず再帰 2 式を満たす写像の族を
   仮定として受け取る形にしている点を見る。
2. **並列の作業ストリーム（式変形の書き方の統一）は今 tick も行った**（姉妹プロジェクトの
   「全行列と可換な行列はスカラー」で、単位行列を行列単位の和へ展開する式を 1 行 1 等号の
   4 段の鎖へ分けた）。次 tick も 1 件進める。
3. そのあと 10f'''c2c2c（$\Psi^{O,\tau_0}_{\lvert O\rvert-1}=S\!\restriction_{O}$ の組み立て）、
   10f'''c2d（符号が $(-1)^{\lvert O\rvert-1}$）。
4. そのあと、各軌道の因子の和が $t^{\lvert O\rvert}-1$ であること（10f'''c3）。
5. そのあと、その根が 1 の $L$ 乗根であること（セクション 10g。ここで $\overline{\mathbb{Q}}$ へ入る）。

**2026-08-10 の tick 48 は、レビューで本文を 1 件直したうえで、次のセクションが要る補題
（最小周期より小さい反復の回数は行く先で見分けられること）を独立した主張として置き、
四層すべてで完了させた。**

1. **レビュー**: 今 tick で書いた本文 1 ブロック
   （`claim_row_shift_iterate_distinct_below_period`）と Lean 3 本（`RowShiftIterateDistinct` 系）。
   とくに、本文の準備の段が $\lvert O(\tau)\rvert=e(\tau)$ の証明の中の議論を書き直したものに
   なっている点（Lean は既存の補題を引いており、本文が二重に書いていることと対応が取れているか）と、
   必要十分版の述語に上界の条件を畳み込んだ持ち方が「仮定は実際に使っている性質だけ」の要件を
   満たしているかを見る。
2. **並列の作業ストリーム（式変形の書き方の統一）は今 tick も行った**（姉妹プロジェクトの
   「クロネッカー積がつくる基底」の Step 1・Step 2 を 1 行 1 等号の鎖へ分けた）。次 tick も 1 件進める。
3. そのあと 10f'''c2c2（巡回シフトの制限が $\lvert O\rvert-1$ 個の互換の積であること。
   $\Psi^{O,\tau_0}_{\lvert O\rvert-1}=S\!\restriction_{O}$）、
   10f'''c2d（符号が $(-1)^{\lvert O\rvert-1}$）。
4. そのあと、各軌道の因子の和が $t^{\lvert O\rvert}-1$ であること（10f'''c3）。
5. そのあと、その根が 1 の $L$ 乗根であること（セクション 10g。ここで $\overline{\mathbb{Q}}$ へ入る）。

**2026-08-10 の tick 47 は、レビューで本文を 1 件直したうえで、セクション 10f'''c2c を
10f'''c2c1・10f'''c2c2 の 2 つへ割り直し、その最初（軌道の上の互換の反復合成の定義と、
それが軌道の上の全単射であること）を四層すべてで完了させた。**

1. **レビュー**: 今 tick で書いた本文 2 ブロック（`def_orbit_transposition_composite` /
   `claim_orbit_transposition_composite_bijective`）と Lean 3 本（`OrbitTranspositionComposite` 系）。
   とくに、合成の順（添字の小さい互換ほど先に作用する）を本文が主張ではなく段落の注意として
   述べている点と、Lean の具体版が帰納法の一歩で `show` を置いて高階の単一化を避けている点を見る。
2. **並列の作業ストリーム（式変形の書き方の統一）は今 tick も行った**（姉妹プロジェクトの「クロネッカー積の転置」にラベル参照を入れた）。次 tick も 1 件進める。
3. そのあと 10f'''c2c2（巡回シフトの制限が $\lvert O\rvert-1$ 個の互換の積であること。
   $\Psi^{O,\tau_0}_{\lvert O\rvert-1}=S\!\restriction_{O}$ を各点での値の帰納法で示す）、
   10f'''c2d（符号が $(-1)^{\lvert O\rvert-1}$）。
4. そのあと、各軌道の因子の和が $t^{\lvert O\rvert}-1$ であること（10f'''c3）。
5. そのあと、その根が 1 の $L$ 乗根であること（セクション 10g。ここで $\overline{\mathbb{Q}}$ へ入る）。

**2026-08-10 の tick 45 は、tick 44 が未検証で残した Lean を通して 10f'''c2a（軌道の上の
全単射の符号の値）を `done` にし、あわせて 10f'''c2b1（軌道の 2 点を入れ替える写像＝互換の
定義と、その制限が軌道の上の全単射であること）を四層すべてで完了させた。**
tick 44 の Lean が落ちていた原因は、必要十分版の定理名 `sign_mul_self` が既存の
`PermutationSign.lean` の同名定理と同じ名前空間で衝突していたことである（`signOn_` へ改名した）。

1. **レビュー**: 今 tick で書いた本文 2 ブロック（`def_orbit_transposition` /
   `claim_orbit_transposition_bijective`）と Lean 3 本（`OrbitTransposition` 系）。
   とくに、本文が「自分自身を逆写像に持つので全単射」と述べていて逆写像の存在から
   全単射性が出ることを主張として引いていない点と、導出を `rfl` ではなく各点の等式で
   述べた理由が正しいかを見る。
2. そのあと 10f'''c2b2（互換の符号が $-1$ であること。$\tau_a\prec\tau\prec\tau_b$ を満たす
   $\tau$ ごとに転倒対が 2 個ずつできることから $\mathrm{inv}_{O}$ が奇数だと出す）、
   10f'''c2c（巡回シフトの制限が $\lvert O\rvert-1$ 個の互換の積）、
   10f'''c2d（符号が $(-1)^{\lvert O\rvert-1}$）。
3. そのあと、各軌道の因子の和が $t^{\lvert O\rvert}-1$ であること（10f'''c3）。
4. そのあと、その根が 1 の $L$ 乗根であること（セクション 10g。ここで $\overline{\mathbb{Q}}$ へ入る）。

さらに、シフト行列の特性多項式がその冪の因子であることを示した。
**四層すべてを満たしている**（2026-08-10 の tick 64）。ここにも $\mathbb{R}/\mathbb{C}$ は現れない。

- $\chi_U\cdot g=\bigl(t^{L}+\iota(-\kappa(1))\bigr)^{\lvert\mathcal{O}_L\rvert}$ を満たす
  $g\in\mathbb{Z}[x][t]$ が存在する。すなわち $\chi_U$ は $t^{L}+\iota(-\kappa(1))$ の
  $\lvert\mathcal{O}_L\rvert$ 乗を $\mathbb{Z}[x][t]$ の中で割り切る。
  証明は、各軌道 $O$ について $a(O)\cdot h=t^{L}+\iota(-\kappa(1))$ を満たす $h$ を 1 つ選んで
  写像 $b$ とし（$\mathcal{O}_L$ は有限集合なので有限個の選択で済む）、
  $g:=\prod_{O}b(O)$ と置いてから 3 段の鎖（$g$ の定義・$\chi_U=\prod_{O}a(O)$・
  2 つの有限積の積の等式）で閉じるものである。
  必要十分版が示したのは、この段が要求するのが**可換モノイドと、添字の相等が決定できることと、
  添字の型が有限であることの 3 つだけ**であり、特性多項式であることも軌道であることも、
  $a(O)$ が和として作られていることも使っていないことである。
  すなわち「各因子が $c$ を割るならば積が $c$ の添字の個数乗を割る」という言明でしかない。

これで、$2^{L}$ 個の行配位にわたる置換の全体についての和として定義された $\chi_U$ が、
$t^{L}+\iota(-\kappa(1))$ の冪の因子であることが $\mathbb{Z}[x][t]$ の中の整除関係として書けた。
$\overline{\mathbb{Q}}$ へはまだ入っていない。次は根を取る段で入る。

さらに、シフト行列の特性多項式を軌道ごとの因子の積として明示的に書いた。
**四層すべてを満たしている**（2026-08-10 の tick 65）。ここにも $\mathbb{R}/\mathbb{C}$ は現れない。

- $\chi_U=\prod_{O\in\mathcal{O}_L}\bigl(t^{\lvert O\rvert}+\iota(-\kappa(1))\bigr)$。
  証明は 2 段の鎖で、第 1 段が「特性多項式は軌道ごとの和の積である」、
  第 2 段が「軌道ごとの和は $t^{\lvert O\rvert}+\iota(-\kappa(1))$ である」を各因子へ当てる段である。
  第 2 段が使う「有限積の各因子が等しければ有限積が等しい」ことは、mathlib の
  `Finset.prod_congr` へ委ねず、具体版でも添字の集合の元の個数についての帰納法で示した。
  必要十分版が示したのは、新しく必要十分性を問うべき第 2 段が要求するのが
  **可換モノイドと添字の相等が決定できることの 2 つだけ**であり、加法も分配則も軌道も
  添字の型の有限性も、因子が和として作られていることも使っていないことである。
  SageMath は $L=1,\dots,6$ で通過し、因子の指数 $\lvert O\rvert$ が軌道ごとに実際に異なること
  （$L=6$ では $1,2,3,6$ の 4 種類）も記録した。

これで、次に根を取る段（1 の $L$ 乗根であること）が引く形が揃った。

さらに、代数的数の全体 $\overline{\mathbb{Q}}$（$\mathbb{Q}$ の代数閉包を 1 つ固定したもの）と、
1 の $n$ 乗根の全体 $\mu_n=\{z\in\overline{\mathbb{Q}}\mid z^{n}=1\}$ を定義し、次を示した。
**四層すべてを満たしている**（2026-08-10 の tick 66）。**ここで $\overline{\mathbb{Q}}$ へ入った。**

$\overline{\mathbb{Q}}$ は可算集合なので、これは実数体・複素数体への脱出ではない
（住処は `Qbar` であり `realEscape` は書かない）。複素数体の部分体として取る道は採らなかった。
非可算な集合を経由することになるためである。

- $d\mid n$ ならば $\mu_d\subset\mu_n$ である。
  証明は $z\in\mu_d$ を取り、$n=dk$ を満たす $k$ を取ってから 4 段の鎖
  $z^{n}=z^{dk}=(z^{d})^{k}=1^{k}=1$ である。
  必要十分版が示したのは、この段が要求するのが**モノイドだけ**であり、体であることも
  可換性も逆元の存在も代数閉であることも、値が代数的数であることさえ使っていないことである
  （半群まで弱めると $z^{0}=1$ が書けず $n=0$ の場合が言えないので、モノイドは削れない）。
  SageMath は $\overline{\mathbb{Q}}$ そのものを置けないので円分体 $\mathbb{Q}(\zeta_m)$ の中で
  $\mu_m$ を全列挙して確かめた（$d=1,\dots,8$・$n=1,\dots,24$ の 192 組。厳密計算のみ）。

さらに、$\mathbb{Z}[x][t]$ の元の代数的数における値
$\mathrm{ev}_{\xi,z}(f)=\sum_{k}\bigl(\mathrm{cf}_k(f)\bigr)(\xi)\,z^{k}\in\overline{\mathbb{Q}}$ を定義し、
軌道ごとの因子についての主張を示した。**四層すべてを満たしている**（2026-08-10 の tick 67）。
値は $\overline{\mathbb{Q}}$ に留まり、実数体・複素数体へは出ていない。

係数（$\mathbb{Z}[x]$ の元）に入れる $\xi$ と不定元 $t$ に入れる $z$ は別の記号にしてある。

- $\mathrm{ev}_{\xi,z}\bigl(t^{m}+\iota(-\kappa(1))\bigr)=0$ ならば $z\in\mu_{m}$ である。
  証明は 5 段の鎖で値を $z^{m}-1$ まで計算し、$z^{m}=1$ を出すだけである。
  仮定に $m\ge1$ を置いていない（$m=0$ でも因子が零元・$\mu_0=\overline{\mathbb{Q}}$ で成り立つ）。
  必要十分版が示したのは、この段が要求するのが係数環と値の側が可換半環であることと、
  その間の環準同型があることの 3 つだけであることである。

さらに、この評価写像が有限積を有限積へ写すことを示した。
**四層すべてを満たしている**（2026-08-10 の tick 68）。ここにも $\mathbb{R}/\mathbb{C}$ は現れない。

- $\mathrm{ev}_{\xi,z}\bigl(\prod_{i\in s}f_i\bigr)=\prod_{i\in s}\mathrm{ev}_{\xi,z}(f_i)$。
  左辺の積は $\mathbb{Z}[x][t]$ の中、右辺の積は $\overline{\mathbb{Q}}$ の中であり、住む集合が違う。
  証明は $s$ の元の個数についての帰納法で、一歩は 4 段の一続きの鎖である。
  必要十分版を新しく書き起こしていない。この段が要求するのは単位元の保存と積の保存の
  2 つだけであり、それは $\iota\circ\kappa$ の側で既に置いた必要十分版
  （単位元と積を保つ写像は有限積を有限積へ写す）そのものだからである。
  導出はその特殊化として書いた。2 つの具体版が 1 つの言明の特殊化であることが見える。

さらに、代数的数の有限積が 0 ならば 0 である因子があることを示した。
**四層すべてを満たしている**（2026-08-10 の tick 69）。ここにも $\mathbb{R}/\mathbb{C}$ は現れない。

- $\prod_{i\in s}c_i=0$ ならば $c_{i_0}=0$ を満たす $i_0\in s$ が存在する（$c_i\in\overline{\mathbb{Q}}$）。
  証明は $s$ の元の個数についての帰納法である。出発点は「空の積は単位元 $1$ であり
  $1\ne0$ なので仮定を満たす写像が無い」、一歩は因子を 1 つ括り出してから $c_a=0$ か否かで分け、
  $c_a\ne0$ の側で逆元 $c_a^{-1}$ を掛ける 5 段の鎖から $\prod_{i\in s}c_i=0$ を出して
  帰納法の仮定を当てる。
  零因子が無いことを仮定として置かず逆元から導いたのは、必要十分版の手順を具体版と
  同じにするためである。
  必要十分版が示したのは、この段が要求するのが**可換群に零元を添えた構造だけ**
  （積・単位元・零元との積・零元でない元の逆元・$1\ne0$）であり、**足し算を一度も
  使っていない**こと、体であることも代数閉であることも値が代数的数であることも
  添字の型の有限性も使っていないことである。

次は、シフト行列の特性多項式の値を 0 にする代数的数が 1 の $L$ 乗根であることである
（積の値を因子の値の積へ開き、0 になる因子を 1 つ取り、
軌道ごとの因子の根と $\lvert O\rvert\mid L$ を合わせる）。

## 未解決の設計問題

- **content のファイルを分けるときの文書順の決め方。** システム（リポジトリ直下
  `structured-latex/`）は `content/` のファイル名昇順を文書順とみなす。一方リポジトリの規約は
  ファイル名の連番プレフィックスを禁じている。2026-08-08 に 2 つめの章を書くときこれに当たったので、
  本文を 1 ファイル `content/main-text.ts` にまとめたまま章を見出しブロックで区切る形にした
  （ファイルを分けない限り配列順が文書順として機能し、衝突しないため）。
  本文が育ってファイルを分けたくなった時点で決着が要る
  （システム側に明示的な順序宣言を入れるのが筋。人間へ提案してから決める）。

さらに、固有ベクトルを置く場所として、成分を $\overline{\mathbb{Q}}$ に取った行列
$\mathrm{Mat}_{R_L}(\overline{\mathbb{Q}})$ とその積、列ベクトルの全体
$V_L=\{v\mid v:R_L\to\overline{\mathbb{Q}}\}$、および行列の作用
$(A\cdot v)(\tau)=\sum_{\tau'}A_{\tau,\tau'}v(\tau')$ を定義し、次を示した。
**四層すべてを満たしている**（2026-08-10 の tick 71）。
ここにも実数体・複素数体は現れない（$\overline{\mathbb{Q}}$ は可算集合である）。

成分の型が違うので、これは $\mathrm{Mat}_{R_L}(\mathbb{Z}[x])$ とその積とは別の対象である。
作用には点を書き（$A\cdot v$）、行列どうしの積と区別する。

- 行列の積の作用は、作用を 2 度施したものである（$(AB)\cdot v=A\cdot(B\cdot v)$）。
  証明は 8 段の一続きの鎖で、作用と積の定義で二重和へ開き、分配則と結合則で項を書き換え、
  有限和の順序を入れ替えてから、分配則で $A$ の成分を外へ出して作用の定義へ戻す。
  必要十分版が示したのは、この段が要求するのが**添字の型が有限であることと、値の側が
  非単位的半環であることの 2 つだけ**であり、**積の可換性を使っていない**こと
  （成分を非可換環に取っても成り立つことを SageMath でも確かめた）、
  積の単位元も加法の逆元も、値が代数的数であることも添字が行配位であることも
  使っていないことである。

さらに、代数的数を成分とする単位行列 $I^{\overline{\mathbb{Q}}}_L$（対角で $1$、対角の外で $0$）を定義し、
次を示した。**四層すべてを満たしている**（2026-08-10 の tick 74）。
ここにも $\mathbb{R}/\mathbb{C}$ は現れない。

$\mathbb{Z}[x]$ の行列の単位行列 $I$ とは成分の型が違う別の対象なので、上付きで区別する。

- $I^{\overline{\mathbb{Q}}}_L\cdot v=v$（単位行列の作用は列ベクトルを動かさない）。
  証明は 6 段の鎖で、有限和から $\tau'=\tau$ の 1 項を分ける段が本体である。
  必要十分版が示したのは、この段が要求するのが**添字の型が有限で相等が判定できることと、
  加法が可換モノイドであること、および $1\cdot a=a$ と $0\cdot a=0$ の 2 本の等式だけ**であり、
  積の可換性も結合則も分配則も、値が代数的数であることも使っていないことである。

これは、シフト行列の固有値が 1 の $L$ 乗根であることを**特性多項式を経由せず**
$U^{L}=I$ から出すための最後の一歩である（固有ベクトルへ $U$ を $L$ 回作用させて戻す）。
この道筋を採ると、非自明な核を持つ行列の行列式が 0 であることを新たに立てずに済む。

さらに、代数的数を成分とする行列の冪 $A^{k}$（$A^{0}:=I^{\overline{\mathbb{Q}}}_L$、
$A^{k+1}:=A\,A^{k}$）と、作用の反復 $\mathrm{it}^{[k]}_{A}(v)$（$\mathrm{it}^{[0]}_{A}(v):=v$、
$\mathrm{it}^{[k+1]}_{A}(v):=A\cdot(\mathrm{it}^{[k]}_{A}(v))$）を定義し、次を示した。
**四層すべてを満たしている**（2026-08-10 の tick 75）。ここにも $\mathbb{R}/\mathbb{C}$ は現れない。

- $A^{k}\cdot v=\mathrm{it}^{[k]}_{A}(v)$（$k$ についての帰納法。出発点が 3 段の鎖、一歩が 4 段の鎖）。
  出発点は単位行列の作用、一歩は積の作用がそれぞれ本体である。
  冪の出発点を $k=0$ に取り、一歩を**左から**掛ける形にしたのは、一歩で外す因子を左にして
  積の作用の主張をそのまま当てるためである（$\mathbb{Z}[x]$ の行列の冪は $A^{1}:=A$ から
  右へ掛ける形で定めてあり、別の対象である）。右から掛けても同じ行列になる
  （同じ行列の冪どうしは成分が非可換でも可換である）ので、この約束は値ではなく証明の形の話である。
  必要十分版が示したのは、この段が要求するのが**2 本の再帰の式と、単位元の作用・積の作用の
  2 つの等式だけ**であり、行列であることも作用が線型であることも有限性も代数構造も
  一切使っていないことである（mathlib から何も import せずに書けた）。

さらに、固有ベクトルへ行列の冪を作用させると固有値の冪のスカラー倍になることを示した。
**四層すべてを満たしている**（2026-08-10 の tick 76）。ここにも $\mathbb{R}/\mathbb{C}$ は現れない。

- $A\cdot v=z\odot v$ ならば、任意の $k\in\mathbb{N}$ について $A^{k}\cdot v=z^{k}\odot v$ である。
  仮定に使うのは固有ベクトルの 2 条件のうち等式の側だけで、$v\ne o_L$ は使わない。
  証明は、準備としてスカラー倍についての 2 つの等式（$1\odot w=w$ と
  $(y\,z)\odot w=y\odot(z\odot w)$）を成分ごとの鎖で作り、そのうえで $k$ についての帰納法
  （出発点が 4 段の鎖、一歩が 7 段の鎖）である。
  $\overline{\mathbb{Q}}$ について使うのは単位元との積と積の結合則だけである
  （逆元も可換性も体であることも使わない）。
  必要十分版が示したのは、この段が要求するのが**2 本の再帰の式と 6 つの等式だけ**であり、
  とくに作用がスカラー倍と交換することは**その 1 つの行列と 1 つのベクトルについてだけ**
  あればよいことである（mathlib から何も import せずに書けた）。

これで、シフト行列の固有値が 1 の $L$ 乗根であることを $U^{L}=I$ から出す材料のうち、
一般の行列についての部分が揃った。残りは、シフト行列を $\overline{\mathbb{Q}}$ を成分とする
行列として置き直し、$U^{L}=I$ と突き合わせる組み立てである。

さらに、代数的数を成分とする単位行列が積の単位元であることを示した。
**四層すべてを満たしている**（2026-08-11 の tick 81）。ここにも $\mathbb{R}/\mathbb{C}$ は現れない。

- $I^{\overline{\mathbb{Q}}}_LA=A$ かつ $AI^{\overline{\mathbb{Q}}}_L=A$。
  証明は成分ごとに、有限和から 1 項を分ける 7 段の鎖を左右それぞれについて書く
  （左は $\tau'=\tau$ の項、右は $\tau'=\tau''$ の項を分ける）。
  眼目は、この 2 つが同じ言明の左右対称版**ではない**ことである。左が使うのは
  $1\cdot a=a$ と $0\cdot a=0$、右が使うのは $a\cdot1=a$ と $a\cdot0=0$ であり、
  積の可換性を使わない以上、別々の仮定が要る。
  必要十分版も右から掛ける側だけ新しく書いた（左から掛ける側は、既にある
  `identity_action_necSuf`（単位行列の作用が列ベクトルを動かさないことの必要十分版）で
  列ベクトルを $A$ の第 $\tau''$ 列と取れば得られるので、導出で特殊化した）。
  要る仮定は、添字の型が有限で相等が判定できること、値の側が加法可換モノイドであること、
  および上の 2 本の等式だけである（体であることも結合則も分配則も使わない）。

これは、$\overline{\mathbb{Q}}$ の行列の冪を右から掛ける形（$A^{k+1}=A^{k}A$）へ書き直す
帰納法の出発点である（一歩で使うのが積の結合則である）。

さらに、代数的数を成分とする行列の冪が右から掛けても得られること（$A^{k+1}=A^{k}A$）を示した。
**四層すべてを満たしている**（2026-08-11 の tick 82）。ここにも $\mathbb{R}/\mathbb{C}$ は現れない。

冪は $A^{0}:=I^{\overline{\mathbb{Q}}}_L$ から始めて左から掛けて定めてあるので、
右から掛けた形は定義ではなく主張である。

- 任意の $k\in\mathbb{N}$ について $A^{k+1}=A^{k}A$ である。
  証明は $k$ についての帰納法で、出発点が 5 段（冪の定義 2 段・$AI^{\overline{\mathbb{Q}}}_L=A$・
  $A=I^{\overline{\mathbb{Q}}}_LA$・冪の定義へ戻す）、一歩が 4 段（冪の定義・帰納法の仮定・
  積の結合則・冪の定義へ戻す）の鎖である。出発点で単位行列を**左右の両側から**掛けるので、
  単位元の主張の 2 つの等式がどちらも要る。
  必要十分版が示したのは、この段が要求するのが**2 本の再帰の式・単位元の左右 2 つの等式・
  両端が $A$ の三つ組についての結合則の 5 つだけ**であり、一般の結合則も、加法も零元も
  分配則も積の可換性も、型の代数構造も添字の型の有限性も使っていないことである
  （mathlib から何も import していない）。

これが要るのは、$\mathbb{Z}[x]$ の行列の冪が右から掛ける形で定めてあり、
$\mathrm{Ev}_{\xi}$ が行列の冪を保つことの帰納法で一歩の向きを揃える必要があるためである。

さらに、成分ごとの評価 $\mathrm{Ev}_{\xi}$ が行列の冪を保つことを示した。
**四層すべてを満たしている**（2026-08-11 の tick 83）。ここにも $\mathbb{R}/\mathbb{C}$ は現れない。

- $k\ge1$ を満たす任意の整数 $k$ について
  $\mathrm{Ev}_{\xi}(A^{k})=\bigl(\mathrm{Ev}_{\xi}(A)\bigr)^{k}$ である。
  $k\ge1$ に限るのは、$\mathbb{Z}[x]$ の行列の冪が $A^{1}:=A$ から始めて $k\ge1$ でだけ
  定めてあるためである（$\mathbb{Z}[x]$ の行列については単位行列を使う出発点を置いていない）。
  証明は $k$ についての帰納法で、出発点が 4 段（$\mathbb{Z}[x]$ の冪の定義・単位行列を右から
  掛ける・$\overline{\mathbb{Q}}$ の冪の定義 2 段）、一歩が 4 段（$\mathbb{Z}[x]$ の冪の定義・
  評価が積を保つこと・帰納法の仮定・冪が右から掛けても得られること）の鎖である。
  2 つの冪は出発点も一歩の向きも違うので、一歩の最後で向きを揃える主張が要る。
  必要十分版が示したのは、この段が要求するのが**7 本の等式だけ**（写像が積を保つこと 1 本・
  2 つの冪の再帰の式 4 本・単位元を右から掛ける等式 1 本・行き先の冪が右から掛けた形にも
  書けること 1 本）であり、加法も零元も分配則も結合則も積の可換性も、型の代数構造も
  添字の型の有限性も、写像が環準同型であることも使っていないことである
  （mathlib から何も import していない）。

これで、$U^{L}=I$（$\mathrm{Mat}_{R_L}(\mathbb{Z}[x])$ の等式）を $\mathrm{Ev}_{\xi}$ で
$\mathrm{Mat}_{R_L}(\overline{\mathbb{Q}})$ の等式へ運ぶ道具が揃った。

さらに、零でない列ベクトルのスカラー倍が零ベクトルならばスカラーが 0 であることを示した。
**四層すべてを満たしている**（2026-08-11 の tick 84）。ここにも $\mathbb{R}/\mathbb{C}$ は現れない。

- $z\odot v=o_L$ かつ $v\ne o_L$ ならば $z=0$ である。
  証明は、$v\ne o_L$ から $v(\tau_1)\ne0$ を満たす $\tau_1$ を取る準備（写像の相等は
  各点の相等であることによる）と、2 つの鎖である。第 1 の鎖（3 段）は
  $z\,v(\tau_1)=(z\odot v)(\tau_1)=o_L(\tau_1)=0$、第 2 の鎖（5 段）は
  $v(\tau_1)$ の逆元を掛けて $z=0$ を出すものである。
  仮定 $v\ne o_L$ は落とせない（$v=o_L$ なら任意の $z$ について $z\odot v=o_L$ である）。
  必要十分版が示したのは、この段が要求するのがスカラー倍が各点の積であること・
  零ベクトルが各点で零であること・積の右単位元・零でない元の右逆元・積の結合則・
  零元との積の**6 つだけ**であり、加法も分配則も積の可換性も左単位元・左逆元も、
  型の代数構造も添字の型の有限性も、値が代数的数であること（代数閉であることも
  各元が $\mathbb{Q}$ 上代数的であることも）も使っていないことである。

さらに、シフト行列の固有値が 1 の $L$ 乗根であることを示した。
**四層すべてを満たしている**（2026-08-11 の tick 85）。ここにも $\mathbb{R}/\mathbb{C}$ は現れない。

- $\xi\in\overline{\mathbb{Q}}$ を任意に取る。$z$ が $\mathrm{Ev}_{\xi}(U)$ の固有値ならば
  $z\in\mu_{L}$ である。証明は 3 つの鎖と 2 つの適用からなる。第 1 の鎖（3 段）で
  $\bigl(\mathrm{Ev}_{\xi}(U)\bigr)^{L}=\mathrm{Ev}_{\xi}(U^{L})=\mathrm{Ev}_{\xi}(I)
  =I^{\overline{\mathbb{Q}}}_L$、第 2 の鎖（3 段）で $z^{L}\odot v=v$、
  第 3 の鎖（各点の 9 段）で $\bigl(z^{L}+(-1)\bigr)\odot v=o_L$ を出し、
  1 つ前の主張で $z^{L}+(-1)=0$、最後の鎖（5 段）で $z^{L}=1$ とする。
  **行列式の理論を経由していない**（非自明な核を持つ行列の行列式が零元であることを
  立てずに済ませた）。そのため特性多項式の根の同定（$\chi_U$ の値を 0 にする代数的数が
  $\mu_L$ に属すること）とは仮定が違い、一方から他方は出ない。
  必要十分版が示したのは、この段が要求するのが 12 の等式だけであり、
  **指数がそこに現れない**こと（$z^{L}$ は 1 つの元として扱えば足りる）である。
  行列であることも積の可換性・結合則も型の代数構造も添字の型の有限性も使っていない。

さらに、可換な行列が固有空間を保つことを示した。
**四層すべてを満たしている**（2026-08-11 の tick 86）。ここにも $\mathbb{R}/\mathbb{C}$ は現れない。

- $A,B\in\mathrm{Mat}_{R_L}(\overline{\mathbb{Q}})$ が $AB=BA$ を満たすとき、
  $v\in E_{A}(z)$ ならば $B\cdot v\in E_{A}(z)$ である。証明は 5 段の鎖
  （$A\cdot(B\cdot v)=(AB)\cdot v=(BA)\cdot v=B\cdot(A\cdot v)=B\cdot(z\odot v)=z\odot(B\cdot v)$）である。
  固有ベクトルではなく固有空間について述べたのは、$B\cdot v$ が零ベクトルになりうるからである。
  必要十分版が示したのは、この段が要求するのが作用の積 1 本・作用がスカラー倍を保つこと 1 本・
  **その 2 つの行列についてだけ**の可換性の 3 つだけであり、行列であることも
  （作用は行列の型とベクトルの型を受け取る勝手な写像でよい）、積の結合則も単位元も分配則も、
  値の型の代数構造も添字の型の有限性も使っていないことである。

さらに、シフト行列 $U$ と転送行列 $T$ を $\mathrm{Ev}_{\xi}$ で運んだ 2 つの行列が可換であることを
示した。**四層すべてを満たしている**（2026-08-11 の tick 87）。ここにも $\mathbb{R}/\mathbb{C}$ は現れない。

- $\mathrm{Ev}_{\xi}(U)\,\mathrm{Ev}_{\xi}(T)=\mathrm{Ev}_{\xi}(T)\,\mathrm{Ev}_{\xi}(U)$。
  証明は 3 段の鎖である（評価が積を保つことを右辺から左辺へ・$UT=TU$・評価が積を保つこと）。
  可換性そのものを $\overline{\mathbb{Q}}$ の側で示し直してはいない。$\mathbb{Z}[x]$ の側で
  既に示してある等式を写像で運んでいるだけである。
  必要十分版が示したのは、この段が要求するのが**写像が積を保つこと 1 本と、もとの側の
  2 元についての可換性 1 本だけ**であり、行列であることも値の型の代数構造も添字の型の
  有限性も、結合則も単位元も分配則も使っていないことである。

さらに、この 2 つ（可換な行列が固有空間を保つことと、運んだ 2 つの行列の可換性）を合わせて、
転送行列がシフト行列の各固有空間をそれ自身へ写すことを組み立てた。
**四層すべてを満たしている**（2026-08-11 の tick 88）。新しい論法を持たない段なので、
必要十分版は新しく書かず、既存 2 本の特殊化を合わせた導出だけを置いた。

さらに、列ベクトルの有限和 $\bigl(\bigoplus_{i\in s}v_i\bigr)(\tau):=\sum_{i\in s}v_i(\tau)$ を定義し、
次を示した。**四層すべてを満たしている**（2026-08-11 の tick 89）。
ここにも $\mathbb{R}/\mathbb{C}$ は現れない。

有限和は**成分ごとに**定めた（2 元の和 $\oplus$ の繰り返しでは定めない）。繰り返しで定めると
足す順序に依らないことを別に示す必要が生じるが、成分ごとに置けばそれは
$\overline{\mathbb{Q}}$ の有限和が持つ性質にそのまま帰着する。添字集合が空のときの値は零ベクトルである。

- 行列の作用は列ベクトルの有限和を保つ
  （$A\cdot\bigl(\bigoplus_{i\in s}v_i\bigr)=\bigoplus_{i\in s}\bigl(A\cdot v_i\bigr)$）。
  証明は帰納法ではなく 6 段の一続きの鎖である（作用の定義・有限和の定義・元と有限和の積に
  ついての分配則・有限和の順序の入れ替え・作用の定義・有限和の定義）。
  必要十分版が示したのは、この段が要求するのが**作用の側の添字の型が有限であることと、
  値の側が非単位的・非結合的半環であることだけ**であり、有限和の添字の型の有限性は
  要らない（和を取るのは有限部分集合の上だから）こと、そして 2 元の和の版と仮定が
  まったく同じであること、すなわち項の個数を増やしても新しい性質は要らないことである。

さらに、スカラー倍が列ベクトルの有限和を保つことを示した。
**四層すべてを満たしている**（2026-08-11 の tick 90）。
ここにも $\mathbb{R}/\mathbb{C}$ は現れない。

- $z\odot\bigl(\bigoplus_{i\in s}v_i\bigr)=\bigoplus_{i\in s}\bigl(z\odot v_i\bigr)$。
  証明は各点での 5 段の一続きの鎖である（スカラー倍の定義・有限和の定義・元と有限和の積に
  ついての分配則・スカラー倍の定義・有限和の定義）。
  必要十分版が示したのは、この段が要求するのが**元と有限和の積についての分配則 1 本だけ**であり、
  1 つ前の作用の版が要した**点の型の有限性すら要らない**ことである（作用は点にわたる有限和を
  取るので有限性が要るが、この段は各点ごとに独立な等式で、有限和の順序の入れ替えが現れない）。

さらに、列ベクトルを固有空間へ落とす写像
$P_{A,z}(v):=\bigoplus_{k=0}^{L-1}z^{L-k}\odot(A^{k}\cdot v)$ を置き（指数を $L-k$ と書くのは、
$z^{-k}$ と書かずに済ませて逆元を要らなくするためである）、これへの行列の作用が冪の指数を
1 つ進めること（tick 91）と、$A^{L}=I$・$z^{L}=1$ のもとで像が固有空間に入ること（tick 92）を示した。
そのあと、$\mu_L$ にわたる冪の総和へ向けた土台として、代数的数の積の冪が冪の積であること
（$(wz)^{n}=w^{n}z^{n}$。tick 93）、1 の冪根の全体が積で閉じていること（tick 94）、
そして次を示した。**いずれも四層すべてを満たしている。**
ここにも $\mathbb{R}/\mathbb{C}$ は現れない（元は代数的数、指数は自然数である）。

- 1 の冪根の冪は 1 の冪根である（$w\in\mu_n$ ならば任意の $k\in\mathbb{N}$ について
  $w^{k}\in\mu_n$。2026-08-11 の tick 95）。証明は $k$ についての帰納法 1 本で、
  出発点は冪の約束 $w^{0}=1$ と「単位元の反復積は単位元である」から $1\in\mu_n$ を出す段、
  一歩は冪の約束 $w^{k+1}=w^{k}w$ へ積で閉じていることを当てる段である。
  必要十分版が示したのは、この段が **$\mu_n$ が 1 の冪根の全体であることを一切使っていない**
  ことである。要るのは「モノイドの部分集合が単位元を含み積で閉じていること」だけで、
  積の可換性も、$n$ 乗して 1 という条件そのものも使っていない。

さらに、1 の冪根を掛ける写像
$\theta^{(n)}_{w}:\mu_{n}\to\mu_{n}$、$\theta^{(n)}_{w}(z)=wz$ を定義し、次を示した。
**四層すべてを満たしている**（2026-08-11 の tick 96）。
ここにも $\mathbb{R}/\mathbb{C}$ は現れない。

写像を表す文字に $m$ を使わない（多重度 $\Omega_L(m)$ の添字に固定してある）ので $\theta$ とした。
行き先が $\mu_{n}$ に収まることは「1 の冪根の全体は積で閉じている」が与えるので、
定義の中でそれを言ってから写像として定めている。

- $n\ge1$ と $w\in\mu_{n}$ のとき $\theta^{(n)}_{w}$ は全単射であり、逆写像は
  $\theta^{(n)}_{w^{n-1}}$ である。**逆元の記法 $z^{-1}$ を使わずに済んでいる**
  （逆写像を $w^{n-1}$ を掛ける操作として構成するので、逆元の存在を仮定しない）。
  証明は準備の 3 段（$w^{n-1}w=w^{(n-1)+1}=w^{n}=1$）と、2 つの往復
  （第 1 が 5 段、第 2 が 6 段。第 2 だけ積の可換則を 1 度使う）、
  単射性（第 1 の往復を 2 度当てる 3 段の鎖）と全射性（第 2 の往復が原像を与える）である。
  $n\ge1$ が要るのは準備の第 2 段 $(n-1)+1=n$ だけで、$n=0$ のときは
  $\mu_0=\overline{\mathbb{Q}}$ なので $w=0$ が取れて主張が偽になる。
  必要十分版が示したのは、**積の可換性が要らない**ことである。要るのは
  「積で閉じた部分集合の中に両側の逆元を持つ元（$vw=1$ かつ $wv=1$）があること」だけで、
  $n$ も、$n$ 乗して 1 という条件も、$v$ が $w$ の冪であることも使っていない。
  すなわち可換則は、片側の逆元から反対側の逆元を得る手段としてしか使われていない。

さらに、$\mu_n$ が有限集合であるという仮定のもとで冪の和
$S_{n,m}=\sum_{z\in\mu_n}z^{m}\in\overline{\mathbb{Q}}$ を置き、次を示した。
**四層すべてを満たしている**（2026-08-11 の tick 97）。ここにも $\mathbb{R}/\mathbb{C}$ は現れない。

- 任意の $w\in\mu_n$ について $w^{m}S_{n,m}=S_{n,m}$ である（$n\ge1$）。
  証明は 6 段の一続きの鎖 1 本である（$S$ の定義 → 積を有限和へ分配 → $(wz)^{m}=w^{m}z^{m}$
  → 掛ける写像 $\theta^{(n)}_{w}$ の定義 → その全単射性による添字の取り替え → $S$ の定義へ戻る）。
  **$\mu_n$ が有限であることは仮定であって、ここでは示していない。**
  必要十分版が示したのは、この段が使うのが**分配則 1 本と、全単射 1 つと、
  「掛けることが全単射に沿う」という両立条件 1 本だけ**であることである。
  仮定は有限型と、単位元も結合則も持たない半環まで削れた。1 の冪根であることも、
  冪の形であることも、掛ける操作であることも使っていない。

さらに、代数的数の冪の有限和の伸縮を示した。**四層すべてを満たしている**（2026-08-11 の tick 98）。
ここにも $\mathbb{R}/\mathbb{C}$ は現れない。

- $G_{n}(z):=\sum_{k=0}^{n-1}z^{k}$ と置くと $(z-1)G_{n}(z)=z^{n}-1$ である（$z\in\overline{\mathbb{Q}}$、
  $n\in\mathbb{N}$）。証明は $n$ についての帰納法 1 本で、出発点 4 段・一歩 6 段の鎖である。
  これは $z\in\mu_n$ かつ $z\ne1$ のとき $G_{n}(z)=0$ を出す足場であり（体に零因子が無いことによる）、
  $\mu_n$ がちょうど $n$ 個の元を持つことを示す段で使う。
  必要十分版が示したのは、**積の可換性を使っていない**ことである（掛け合わせているのは $z$ と
  $z$ 自身の冪だけなので、可換とは限らない環でそのまま通る）。要るのは環であることだけで、
  体であることも代数閉であることも 1 の冪根であることも使っていない。
  引き算だけは削れない（半環では $z^{n}-1$ という式が書けない）。

さらに、代数的数の積が零元ならば零元でない方で割って他方が零元と分かることを示した。
**四層すべてを満たしている**（2026-08-11 の tick 99）。ここにも $\mathbb{R}/\mathbb{C}$ は現れない。

- $a,b\in\overline{\mathbb{Q}}$ が $ab=0$ と $a\ne0$ を満たすならば $b=0$ である。
  証明は $a^{-1}a=1$ を満たす元を取る準備と、$b=1\cdot b=(a^{-1}a)b=a^{-1}(ab)=a^{-1}\cdot0=0$ の
  5 段の鎖である。伸縮の等式から $G_{n}(z)=0$ を出す段と、$(w^{m}-1)S_{n,m}=0$ から
  $S_{n,m}=0$ を出す段の両方で使う。
  必要十分版が示したのは、**逆元を「すべての零でない元が持つ」形（体であること）ではなく、
  $a$ 1 つが左逆元を持つという仮定として受け取れば足りる**ことである。すなわちこの段は
  「零因子が無いこと」という体の性質を使っておらず、$a$ が左から割れることだけを使っている。
  可換性も加法についての性質も代数閉であることも使っていない。

次は $\mu_n$ がちょうど $n$ 個の元を持つことを示し（有限性の仮定を外すため）、
そのうえで $\mu_L$ の元の冪の総和（指数が $L$ の倍数なら元の個数、そうでなければ 0）を出す。
最後の段の論法は「$w^{m}\ne1$ なる $w$ を取り、上の不変性から $(w^{m}-1)S=0$ を出す」1 本である。

## 確認事項・注意

さらに、正方格子の双対辺写像を定義し、全単射性を示した。
**四層すべてを満たしている**（2026-08-12 の tick 159）。
ここにも $\mathbb{R}/\mathbb{C}$ は現れない。

- 横向き辺 $n_{\mathrm h}(i,j)$ を $n_{\mathrm v}(i,j+\bar1)$ へ、縦向き辺
  $n_{\mathrm v}(i,j)$ を $n_{\mathrm h}(i+\bar1,j)$ へ送る写像 $\delta_L$ は全単射である。
  証明は、横向き辺を $n_{\mathrm v}(i-\bar1,j)$ へ、縦向き辺を
  $n_{\mathrm h}(i,j-\bar1)$ へ送る逆写像 $\eta_L$ を明示し、二つの往復律を
  辺の向きごとに確かめるものである。必要十分版が示したのは、この段が要求するのが
  写像・逆写像・左右の往復律だけであり、辺であることも格子であることも、
  型の代数構造も有限性も使っていないことである。

次は、配位の破れた辺集合を $\delta_L$ で送った像が偶部分グラフであることを示す。

- **検証コードが本文の定義そのものを実装しているかを疑う。** `_shared/defs.sage` の
  `partition_polynomial(L)` は当初、分配多項式を多重度ベクトルから作っていた。本文の定義は
  配位ごとの単項式の和なので、これは定義ではなく係数表示を実装していたことになり、
  係数表示の検証が構成から自明（＝何も確かめない）になっていた。2026-08-08 のレビューで
  定義どおりの実装へ直し、多重度から作る側を `partition_polynomial_from_multiplicity(L)` へ分けた。
- **検証が本文を直させた例を消さない。** 辺集合を「2 元集合の集合」として定義していたため
  周期境界の $L\le2$ で $|E_L|=2L^2$ が破れていた。SageMath 検証が検出し、本文を
  「辺の番号の集合（横向き・縦向きに分割）と端点写像」の定義へ直した。
  経緯は `sagemath/check/partition-polynomial-coefficient-sum/overview.md` に残してある。
- **行への制限は $\rho_i(\sigma)$ と書く。$\sigma_i$ と書かない。** $\sigma$ は格子全体の配位を表す
  記号として固定してあり、添字を付けた形に別の意味を持たせないため（README「記号の濫用を排除する」）。
- 本文の地の文に強調記法（`**`）を使わない（他プロジェクトと同じ運用）。
- 姉妹プロジェクト `exact-solution-of-2d-ising-model/` の計算を引き写さない。
  可算側で書き直せるかを毎回問う（README「姉妹プロジェクトとの違い」）。
- **3 次元へ進むときの方針は
  [docs/discussion/3次元Isingを可算側で書く/](../docs/discussion/3次元Isingを可算側で書く/README.md)
  にある**（2026-08-13 に作成、同日にレビュー反映と立場変更）。**立場は本プロジェクトより強い**：
  宣言した脱出箇所以外では $\mathbb{R}/\mathbb{C}$ を正当化されたものとして使わず、
  そこに属する数のようなものを論理に登場させない。したがって臨界点という実数を主語にせず、
  有理数の二つの集合（高温側・低温側）を対象にし、どちらも「有限の証拠の存在」で定義する。
  高温側の証拠は $\mathbb{Z}[x]$ の多項式の比 $\Phi_S(q)<1$ で、検査は有理数の不等式 1 本、
  集合は構成から再帰的可枚挙。本体の問いは「両側が高々 1 元を除いて有理数を覆うか（切断が定まるか）」。
  技術的な核は、高温側が上向きに閉じることを $\mathbb{R}$ 側の GKS 不等式に頼らず
  $\mathbb{Z}[x]$ の係数の議論で示すこと。校正は 2 次元（境目が $\sqrt2-1$ と分かっている）で先に行い、
  本プロジェクトの零点・$\Lambda$ の道具立てをそのまま使う。


## 完了済み

- プロジェクト雛形の作成（構造化テキスト・SageMath・Lean・docs、および検査の一式）。
- 住処 `habitat` と脱出 `realEscape` の型・実行時強制、負テスト 8 件・実行時テスト 9 件。
- 可算な住処を宣言したブロックの数式に $\mathbb{R}/\mathbb{C}$ が現れないことの機械検査。
