# 奇数軌道の反転による反対称成分の積の符号反転の検算

**対象ラベル**: `claim_selected_odd_orbit_skew_product_neg`

2026-10-11 実行済み。本文30計算・判定行の13,824確認と独立検算、計31チェックファイルがすべて PASS。

有限集合の点・個数・置換の符号は整数、行列の成分と積は円分体 $\mathbb Q(\zeta_8)$ を係数とする多項式環で厳密に計算する。これは本文の $\overline{\mathbb Q}[x]$ の具体例であり、浮動小数点・実数体への脱出は使わない。

大きさ0〜6の全874置換を列挙し、自然順序と二元以上では逆順序も付けた1,746例から、不動点がなく奇数軌道を持つ172例を取る。大きさ別の対象数は0・0・0・4・0・88・80で、対象が空の場合も検査する。各対象例に密・零・疎の3行列を与え、計516行列例で多項式の行を検算する。

密行列の上三角成分は $(i+1)+(j+1)\zeta_8+(i+j+1)x+\zeta_8^{i+j+1}x^2$、下三角成分はその負号である。疎行列はさらに $j-i$ が奇数の成分を零にする。非零の全積は密行列172例・零行列0例・疎行列12例。軌道外が空の52対象例、二つの奇数軌道を持つ80対象例、符号が負の40対象例と正の132対象例を含む。

| ファイル | 本文の計算・判定 | 状態 | 確認数 |
|---|---|---|---|
| `check_least_point_membership.sage` | 最小点の奇数点集合への所属: $m\in\operatorname{OddPts}(\sigma)$ | PASS | 172 |
| `check_selected_length_odd.sage` | 選んだ始点の軌道長の奇数性: $\operatorname{len}_{\sigma}(m)\text{ は奇数}$ | PASS | 172 |
| `check_selected_card_orbit.sage` | 選んだ台の定義による個数の置換: $\lvert C\rvert=\lvert\operatorname{Orb}_{\sigma}(m)\rvert$ | PASS | 172 |
| `check_orbit_card_length.sage` | 軌道の個数と長さの一致: $\lvert\operatorname{Orb}_{\sigma}(m)\rvert=\operatorname{len}_{\sigma}(m)$ | PASS | 172 |
| `check_selected_card_odd.sage` | 選んだ台の個数の奇数性: $\lvert C\rvert\text{ は奇数}$ | PASS | 172 |
| `check_forward_invariance.sage` | 軌道の前向き不変性: $\sigma(i)\in C\Longleftrightarrow i\in C$ | PASS | 932 |
| `check_inverse_invariance.sage` | 不変条件を逆像へ適用: $\sigma^{-1}(i)\in C\Longleftrightarrow\sigma(\sigma^{-1}(i))\in C$ | PASS | 932 |
| `check_inverse_cancel_membership.sage` | 順逆相殺による所属の同値: $\sigma(\sigma^{-1}(i))\in C\Longleftrightarrow i\in C$ | PASS | 932 |
| `check_restricted_left_inverse.sage` | 制限写像の左逆性: $\sigma^{-1}(\sigma(i))=i$ | PASS | 612 |
| `check_restricted_right_inverse.sage` | 制限写像の右逆性: $\sigma(\sigma^{-1}(i))=i$ | PASS | 612 |
| `check_selected_reversal_definition.sage` | 選んだ奇数軌道の反転を展開: $\tau=\rho_C(\sigma)$ | PASS | 172 |
| `check_inside_reversal_definition.sage` | 軌道内の反転の定義: $\prod_{i\in C}A_{i,\tau(i)}=\prod_{i\in C}A_{i,\sigma^{-1}(i)}$ | PASS | 516 |
| `check_inside_reindex.sage` | 軌道内の全単射による再添字付け: $\prod_{i\in C}A_{i,\sigma^{-1}(i)}=\prod_{j\in C}A_{\sigma(j),\sigma^{-1}(\sigma(j))}$ | PASS | 516 |
| `check_inside_inverse_cancel.sage` | 再添字付けした成分の逆写像の相殺: $\prod_{j\in C}A_{\sigma(j),\sigma^{-1}(\sigma(j))}=\prod_{j\in C}A_{\sigma(j),j}$ | PASS | 516 |
| `check_inside_skew.sage` | 各成分の反対称性: $\prod_{j\in C}A_{\sigma(j),j}=\prod_{j\in C}(-A_{j,\sigma(j)})$ | PASS | 516 |
| `check_inside_extract_negatives.sage` | 有限積から負号を分離: $\prod_{j\in C}(-A_{j,\sigma(j)})=(-1)^{\lvert C\rvert}\prod_{j\in C}A_{j,\sigma(j)}$ | PASS | 516 |
| `check_inside_odd_power.sage` | 奇数乗された負の一の値: $(-1)^{\lvert C\rvert}\prod_{j\in C}A_{j,\sigma(j)}=(-1)\prod_{j\in C}A_{j,\sigma(j)}$ | PASS | 516 |
| `check_inside_negative_one.sage` | 負の一との積: $(-1)\prod_{j\in C}A_{j,\sigma(j)}=-\prod_{j\in C}A_{j,\sigma(j)}$ | PASS | 516 |
| `check_outside_unchanged.sage` | 軌道外の積の不変性: $\prod_{i\in\mathcal J\setminus C}A_{i,\tau(i)}=\prod_{i\in\mathcal J\setminus C}A_{i,\sigma(i)}$ | PASS | 516 |
| `check_whole_split.sage` | 全体の積を内側と外側へ分離: $\prod_{i\in\mathcal J}A_{i,\tau(i)}=P_\tau Q_\tau$ | PASS | 516 |
| `check_whole_inside_substitution.sage` | 内側の積の符号反転を代入: $P_\tau Q_\tau=(-P_\sigma)Q_\tau$ | PASS | 516 |
| `check_whole_outside_substitution.sage` | 外側の積の不変性を代入: $(-P_\sigma)Q_\tau=(-P_\sigma)Q_\sigma$ | PASS | 516 |
| `check_whole_extract_negative.sage` | 第一因子の負号を取り出す: $(-P_\sigma)Q_\sigma=-(P_\sigma Q_\sigma)$ | PASS | 516 |
| `check_whole_join.sage` | 分離した積を全体へ戻す: $-(P_\sigma Q_\sigma)=-\prod_{i\in\mathcal J}A_{i,\sigma(i)}$ | PASS | 516 |
| `check_coefficient_tau_definition.sage` | 反転後の定数係数の定義: $c_\tau=\widehat{\iota_{\mathbb Z}(\operatorname{sgn}(\tau))}$ | PASS | 172 |
| `check_coefficient_sign_preservation.sage` | 置換の符号保存の代入: $\widehat{\iota_{\mathbb Z}(\operatorname{sgn}(\tau))}=\widehat{\iota_{\mathbb Z}(\operatorname{sgn}(\sigma))}$ | PASS | 172 |
| `check_coefficient_sigma_definition.sage` | 元の定数係数の定義へ戻す: $\widehat{\iota_{\mathbb Z}(\operatorname{sgn}(\sigma))}=c_\sigma$ | PASS | 172 |
| `check_signed_coefficient_substitution.sage` | 符号付き項に係数の等号を代入: $c_\tau\prod_i A_{i,\tau(i)}=c_\sigma\prod_i A_{i,\tau(i)}$ | PASS | 516 |
| `check_signed_product_substitution.sage` | 符号付き項に積の符号反転を代入: $c_\sigma\prod_i A_{i,\tau(i)}=c_\sigma(-\prod_i A_{i,\sigma(i)})$ | PASS | 516 |
| `check_signed_extract_negative.sage` | 第二因子の負号を取り出す: $c_\sigma(-\prod_i A_{i,\sigma(i)})=-(c_\sigma\prod_i A_{i,\sigma(i)})$ | PASS | 516 |
| `check_definition.sage` | 軌道と符号の独立実装の照合、反対称性、空積、本文の二つの結論、標本の範囲 | PASS | 172対象例・516行列例 |

軌道の台は無向グラフ探索と順反復を別々に実装し、軌道長は本文の定義どおり台の個数から求め、始点へ初めて戻るまでの回数との一致を追加で照合する。符号は転倒数から求め、Sage の `Permutation.signature()` と照合する。各積は成分から直接計算し、符号反転の結論を標本生成や右辺の定義に仮定しない。

有限標本の検算であり、任意の有限集合・任意の反対称行列についての証明は本文とLeanが担う。有限和の相殺は検算範囲に含めない。

実行（プロジェクト直下）:

```sh
sage -c "__file__ = 'sagemath/check/selected-odd-orbit-skew-product-neg/check.sage'; load(__file__)"
```

各行は `check.sage` を該当する `check_<内容>.sage` に置き換えて単独実行できる。
