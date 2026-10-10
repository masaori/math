# 非単射の添字写像に対応する置換和の相殺の行別検算

**対象ラベル**: `claim_polynomial_determinant_noninjective_cancellation`

対象は `structured-latex/content/main-text.ts` の「非単射の添字写像に対応する置換和は零」の証明である。本文の45等号と1不等号を各一ファイルに対応させ、帰納法で使う集合の条件は別のファイルで検査する。`check.sage` はこれら全47ファイルを実行する。

係数は円分体 $\mathbb Q(\zeta_8)$、多項式は $\mathbb Q(\zeta_8)[x]$ として厳密に計算する。整数から円分体への包含と定数多項式への包含を別々に実装し、多項式・整数・添字・置換・真偽値を型別に検査する。実数・複素数への数値評価、浮動小数点、許容誤差は使わない。

添字集合は $\mathcal J=\{0,\ldots,n-1\}$（$n=2,3$）。全23個の非単射写像と、各写像について $a\ne b$ かつ $f(a)=f(b)$ となる全順序付き衝突対を列挙する。写像と衝突対の組は58個、それぞれ全置換を取り、組は計332個である。$n=1$ では非単射写像がないため入力を作らない。

各 $n$ で次の三種類の多項式行列を使い、写像・衝突対・行列の組は174個となる。

- 対角行列：対角成分は $i+1+\zeta_8 x$、それ以外は零。
- 密行列：成分は $\delta_{ij}+\zeta_8^{1+i+2j}x+(1+in+j)x^2$。
- 疎行列：対角成分は $1+\zeta_8 x$、$j\equiv i+1\pmod n$ の成分は $\zeta_8^{i+1}x^2$、それ以外は零。

密行列の重み332個は全て非零であることも確認した。さらに、恒等写像を行添字に使った比較用の置換和は定数係数が1であることを確かめ、入力が全て零になる検算を避けている。

## 集合の帰納法の検算範囲

各写像・衝突対について置換集合の全ての部分集合を列挙する（候補は合計3472個）。$\Theta(\varphi)=\varphi\circ t$ で安定なものを選び、空集合と全置換集合が含まれること、および個数が $2^{n!/2}$ であることを検査する。三種類の行列込みで安定部分集合は1320個であり、非空の各集合からの全ての選択 $\varphi$（計3912組）について二点を除去する。残集合が真部分集合であること、個数が減ること、$\Theta$ で安定であること、二つの除去点へ写らないことを検査する。本文の和の六等号は、この3912組をそれぞれ比較する。

除去点の逆像に関する五等号は、矛盾した仮定から数値入力を作らない。第一除去点への像を仮定する二等号では $\rho=\Theta(\varphi)$、第二除去点への像を仮定する三等号では $\rho=\varphi$ と置き、それぞれ対応する像の条件を確認して計算する。ここでは $\rho\in\mathcal P'$ を仮定していない。実際の残集合の元がこれらの除去点へ写らないことは、別の構造検算で全列挙する。

残集合の和が零である行は、有限入力でその和を直接計算して比較する。これは任意の有限集合に対する強い帰納法を証明するものではない。一般の証明は本文と Lean が担う。

## 本文との対応

表は本文の計算順で並べる。`C` は定数多項式の包含、`iota_Z` は整数の包含、`S` は $\mathcal P$、`R` は二点を除いた $\mathcal P'$ を表す。

| ファイル | 本文の式ペア | 型 | 状態 | 実測件数 |
|---|---|---|---|---|
| `check_collision_at_left_transposition.sage` | 左点の互換：`f(t(a)) = f(b)` | 添字の等号 | PASS | 58 |
| `check_collision_at_left_equal_image.sage` | 左点の像の一致：`f(b) = f(a)` | 添字の等号 | PASS | 58 |
| `check_collision_at_right_transposition.sage` | 右点の互換：`f(t(b)) = f(a)` | 添字の等号 | PASS | 58 |
| `check_collision_at_right_equal_image.sage` | 右点の像の一致：`f(a) = f(b)` | 添字の等号 | PASS | 58 |
| `check_collision_away_from_pair.sage` | 衝突対の外側：`f(t(i)) = f(i), i != a,b` | 添字の等号 | PASS | 54 |
| `check_involution_outer_definition.sage` | 対を作る写像の外側の展開：`Theta(Theta(phi))(i) = Theta(phi)(t(i))` | 添字の等号 | PASS | 988 |
| `check_involution_inner_definition.sage` | 対を作る写像の内側の展開：`Theta(phi)(t(i)) = phi(t(t(i)))` | 添字の等号 | PASS | 988 |
| `check_involution_transposition.sage` | 互換を二回施す：`phi(t(t(i))) = phi(i)` | 添字の等号 | PASS | 988 |
| `check_no_fixed_point_definition.sage` | 左点での写像の展開：`Theta(phi)(a) = phi(t(a))` | 添字の等号 | PASS | 332 |
| `check_no_fixed_point_transposition.sage` | 左点での互換の展開：`phi(t(a)) = phi(b)` | 添字の等号 | PASS | 332 |
| `check_no_fixed_point_inequality.sage` | 単射性による不等号：`phi(b) != phi(a)` | 添字の不等号 | PASS | 332 |
| `check_product_definition.sage` | 対の積の定義：`P[Theta(phi)] = Prod(B[f(i),Theta(phi)(i)] for i in J)` | 多項式の等号 | PASS | 996 |
| `check_product_theta_definition.sage` | 積の中の写像の展開：`Prod(B[f(i),Theta(phi)(i)] for i in J) = Prod(B[f(i),phi(t(i))] for i in J)` | 多項式の等号 | PASS | 996 |
| `check_product_row_collision.sage` | 衝突による行添字の置換：`Prod(B[f(i),phi(t(i))] for i in J) = Prod(B[f(t(i)),phi(t(i))] for i in J)` | 多項式の等号 | PASS | 996 |
| `check_product_reindex.sage` | 互換による積の再添字付け：`Prod(B[f(t(i)),phi(t(i))] for i in J) = Prod(B[f(j),phi(j)] for j in J)` | 多項式の等号 | PASS | 996 |
| `check_product_fold.sage` | 元の積へ戻す：`Prod(B[f(j),phi(j)] for j in J) = P[phi]` | 多項式の等号 | PASS | 996 |
| `check_sign_definition.sage` | 符号内の写像の展開：`sgn(Theta(phi)) = sgn(phi o t)` | 整数の等号 | PASS | 332 |
| `check_sign_composition.sage` | 合成の符号：`sgn(phi o t) = sgn(phi)*sgn(t)` | 整数の等号 | PASS | 332 |
| `check_sign_transposition.sage` | 互換の符号：`sgn(phi)*sgn(t) = sgn(phi)*(-1)` | 整数の等号 | PASS | 332 |
| `check_sign_negation.sage` | 整数の符号反転：`sgn(phi)*(-1) = -sgn(phi)` | 整数の等号 | PASS | 332 |
| `check_coefficient_definition.sage` | 対の定数係数の定義：`c[Theta(phi)] = C(iota_Z(sgn(Theta(phi))))` | 多項式の等号 | PASS | 996 |
| `check_coefficient_sign_negation.sage` | 符号の負号を代入：`C(iota_Z(sgn(Theta(phi)))) = C(iota_Z(-sgn(phi)))` | 多項式の等号 | PASS | 996 |
| `check_coefficient_integer_embedding.sage` | 整数の包含と負号：`C(iota_Z(-sgn(phi))) = C(-iota_Z(sgn(phi)))` | 多項式の等号 | PASS | 996 |
| `check_coefficient_constant_embedding.sage` | 定数多項式の包含と負号：`C(-iota_Z(sgn(phi))) = -C(iota_Z(sgn(phi)))` | 多項式の等号 | PASS | 996 |
| `check_coefficient_fold.sage` | 元の係数へ戻す：`-C(iota_Z(sgn(phi))) = -c[phi]` | 多項式の等号 | PASS | 996 |
| `check_weight_definition.sage` | 対の重みの定義：`w[Theta(phi)] = c[Theta(phi)]*P[Theta(phi)]` | 多項式の等号 | PASS | 996 |
| `check_weight_coefficient_negation.sage` | 重みの係数を反転：`c[Theta(phi)]*P[Theta(phi)] = (-c[phi])*P[Theta(phi)]` | 多項式の等号 | PASS | 996 |
| `check_weight_product_invariance.sage` | 重みの積を元へ戻す：`(-c[phi])*P[Theta(phi)] = (-c[phi])*P[phi]` | 多項式の等号 | PASS | 996 |
| `check_weight_negated_product.sage` | 積の負号を外へ出す：`(-c[phi])*P[phi] = -(c[phi]*P[phi])` | 多項式の等号 | PASS | 996 |
| `check_weight_fold.sage` | 元の重みへ戻す：`-(c[phi]*P[phi]) = -w[phi]` | 多項式の等号 | PASS | 996 |
| `check_pair_substitute_negative.sage` | 対の和へ負号を代入：`w[phi]+w[Theta(phi)] = w[phi]+(-w[phi])` | 多項式の等号 | PASS | 996 |
| `check_pair_additive_inverse.sage` | 加法逆元で相殺：`w[phi]+(-w[phi]) = 0` | 多項式の等号 | PASS | 996 |
| `check_empty_sum.sage` | 空集合の帰納基底：`Sum(w[phi] for phi in emptyset) = 0` | 多項式の等号 | PASS | 174 |
| `check_exclude_first_involution.sage` | 第一除去点の逆像に二回写像：`rho = Theta(Theta(rho)), rho=Theta(phi)` | 置換の等号 | PASS | 332 |
| `check_exclude_first_substitution.sage` | 第一除去点への像を代入：`Theta(Theta(rho)) = Theta(phi), Theta(rho)=phi` | 置換の等号 | PASS | 332 |
| `check_exclude_second_involution.sage` | 第二除去点の逆像に二回写像：`rho = Theta(Theta(rho)), rho=phi` | 置換の等号 | PASS | 332 |
| `check_exclude_second_substitution.sage` | 第二除去点への像を代入：`Theta(Theta(rho)) = Theta(Theta(phi)), Theta(rho)=Theta(phi)` | 置換の等号 | PASS | 332 |
| `check_exclude_second_return.sage` | 第二除去点の逆像を戻す：`Theta(Theta(phi)) = phi` | 置換の等号 | PASS | 332 |
| `check_sum_erase_first.sage` | 選んだ項を取り出す：`Sum(w[rho] for rho in S) = w[phi]+Sum(w[rho] for rho in S minus {phi})` | 多項式の等号 | PASS | 3912 |
| `check_sum_erase_second.sage` | 対の項を取り出す：`w[phi]+Sum(w[rho] for rho in S minus {phi}) = w[phi]+(w[Theta(phi)]+Sum(w[rho] for rho in R))` | 多項式の等号 | PASS | 3912 |
| `check_sum_associate.sage` | 対の和の括弧を揃える：`w[phi]+(w[Theta(phi)]+Sum(w[rho] for rho in R)) = (w[phi]+w[Theta(phi)])+Sum(w[rho] for rho in R)` | 多項式の等号 | PASS | 3912 |
| `check_sum_cancel_pair.sage` | 対の和を零にする：`(w[phi]+w[Theta(phi)])+Sum(w[rho] for rho in R) = 0+Sum(w[rho] for rho in R)` | 多項式の等号 | PASS | 3912 |
| `check_sum_induction_hypothesis.sage` | 残集合の帰納仮定：`0+Sum(w[rho] for rho in R) = 0+0` | 多項式の等号 | PASS | 3912 |
| `check_sum_zero_addition.sage` | 零の加法：`0+0 = 0` | 多項式の等号 | PASS | 3912 |
| `check_whole_sum_definition.sage` | 全置換和の重み表示：`Sum(c[phi]*Prod(B[f(i),phi(i)] for i in J) for phi in Perm(J)) = Sum(w[phi] for phi in Perm(J))` | 多項式の等号 | PASS | 174 |
| `check_whole_sum_cancellation.sage` | 全置換集合への帰納法の帰結：`Sum(w[phi] for phi in Perm(J)) = 0` | 多項式の等号 | PASS | 174 |
| `check_structure.sage` | 安定性・除去・非零検算の補助条件：`各条件を真偽値として検査する（等式へ変換しない）` | 真偽値 | PASS | 14984 |

2026-10-10 実行：全47ファイルと統合実行が PASS。等号47,828件、不等号332件、構造条件14,984件、合計63,144件を確認した。有限検算であり、一般の有限集合についての証明ではない。

## 実行方法

プロジェクト直下で全ての行を実行する。

```sh
sage sagemath/check/polynomial-determinant-noninjective-cancellation/check.sage
```

各行は `sage <該当する check_*.sage>` で単独実行できる。失敗時は例外を送出し、非零の終了コードを返す。
