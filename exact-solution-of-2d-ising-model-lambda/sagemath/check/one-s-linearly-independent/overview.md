# SageMath Check: 一と s の一次独立性

**対象ラベル**: `claim_one_s_linearly_independent`

- 対象: `structured-latex/content/main-text.ts` の「一と s の一次独立性」の証明。
- 実行日: 2026-10-04。
- 結果: 五計算鎖の 24 等号中、21 行・43,761 等式を厳密検算。矛盾仮定を使う 3 行は数値例がなく、通過件数から除外して Lean で確認した。
- 帰属: $a,b,r\in\mathbb Q$ を `QQ`、$s\in\overline{\mathbb Q}$ を `QQbar`、包含写像 $\iota:\mathbb Q\hookrightarrow\overline{\mathbb Q}$ を `QQbar(...)` で実装する。実数・複素数への脱出と浮動小数点計算はない。

## 行別検算

表の順序は本文の等号順である。各ファイルに式の両辺の原文と所属集合を記した。
標本は分子 $-6,\ldots,6$、分母 $1,\ldots,6$ から重複を除いた 47 有理数と、
$s^2=2$ の 2 根である。$b\ne0$ の行では 46 個の非零係数を使う。

| ファイル | 検証内容 | 状態 | 結果 |
| --- | --- | --- | --- |
| [check_inverse_product_embedding.sage](check_inverse_product_embedding.sage) | 逆元の積を包含写像の内側へ移す | 通過 | 46 等式 |
| [check_inverse_cancellation.sage](check_inverse_cancellation.sage) | 有理数の逆元を消去する | 通過 | 46 等式 |
| [check_embedding_one.sage](check_embedding_one.sage) | 包含写像が単位元を保つ | 通過 | 1 等式 |
| [check_rearrange_insert_zero.sage](check_rearrange_insert_zero.sage) | 移項のため零元を挿入する | 通過 | 4324 等式 |
| [check_rearrange_insert_additive_inverse.sage](check_rearrange_insert_additive_inverse.sage) | 加法の逆元の和を挿入する | 通過 | 4324 等式 |
| [check_rearrange_associativity.sage](check_rearrange_associativity.sage) | 移項の加法を結合する | 通過 | 4324 等式 |
| [check_rearrange_zero_assumption.sage](check_rearrange_zero_assumption.sage) | 零になるという矛盾仮定を代入する | 数値例なし・Lean 通過 | 件数対象外 |
| [check_rearrange_remove_zero.sage](check_rearrange_remove_zero.sage) | 移項後の零元を除く | 通過 | 4324 等式 |
| [check_root_insert_one.sage](check_root_insert_one.sage) | 根に単位元を掛ける | 通過 | 4324 等式 |
| [check_root_insert_inverse_product.sage](check_root_insert_inverse_product.sage) | 移した逆元の積を代入する | 通過 | 4324 等式 |
| [check_root_product_associativity.sage](check_root_product_associativity.sage) | 根の積を結合する | 通過 | 4324 等式 |
| [check_root_rearranged_assumption.sage](check_root_rearranged_assumption.sage) | 矛盾仮定から得た移項結果を代入する | 数値例なし・Lean 通過 | 件数対象外 |
| [check_root_negative_embedding.sage](check_root_negative_embedding.sage) | 加法の逆元を包含写像の内側へ移す | 通過 | 4324 等式 |
| [check_root_product_embedding.sage](check_root_product_embedding.sage) | 根を表す積を包含写像の内側へ移す | 通過 | 4324 等式 |
| [check_root_rational_definition.sage](check_root_rational_definition.sage) | 有理数 r の定義を代入する | 通過 | 4324 等式 |
| [check_square_product_embedding.sage](check_square_product_embedding.sage) | 有理数の平方を包含写像で移す | 通過 | 47 等式 |
| [check_square_root_assumption.sage](check_square_root_assumption.sage) | 矛盾仮定から得た根の表示を代入する | 数値例なし・Lean 通過 | 件数対象外 |
| [check_square_root_equation.sage](check_square_root_equation.sage) | 根の平方の仮定を代入する | 通過 | 2 等式 |
| [check_coefficient_insert_zero.sage](check_coefficient_insert_zero.sage) | 係数に零元を加える | 通過 | 94 等式 |
| [check_coefficient_zero_product.sage](check_coefficient_zero_product.sage) | 零元との積を挿入する | 通過 | 94 等式 |
| [check_coefficient_embedding_zero.sage](check_coefficient_embedding_zero.sage) | 包含写像の零元を積へ代入する | 通過 | 94 等式 |
| [check_coefficient_b_zero.sage](check_coefficient_b_zero.sage) | 証明済みの b の零性を代入する | 通過 | 94 等式 |
| [check_coefficient_zero_assumption.sage](check_coefficient_zero_assumption.sage) | 零になるという仮定を零係数へ適用する | 通過 | 2 等式 |
| [check_zero_embedding.sage](check_zero_embedding.sage) | 零元を包含写像の像として書く | 通過 | 1 等式 |

移項への仮定代入、根への移項結果の代入、平方への根の表示の代入は、
$b\ne0$ と $\iota(a)+\iota(b)s=0$ を同時に要求する。この標本は存在しないため、
数値検算の成功としない。最後の係数の消去では $a=b=0$ と各根の 2 例が仮定を満たす。
包含写像の単射性と有理数平方の非二性から矛盾を導く推論も Lean が確認する。

## Lean との対応

具体版 `oneSLinearlyIndependent` と必要十分版 `one_s_linearly_independent_necSuf` は、
逆元の移送 3 等号、移項 5 等号、根の有理数表示 7 等号、平方の移送 3 等号、
残る係数の消去 6 等号を同じ順序で持つ。具体版は必要十分版を呼ばずに証明する。
導出版 `oneSLinearlyIndependent_from_necSuf` は包含写像と有理数平方の非二性を必要十分版へ渡す。
必要十分版の仮定は係数体・値の体・環準同型・係数体に平方が 2 の元がないこと・根と零和の等式である。

対象の 3 モジュールの `lake build` は 2026-10-04 に通過した。
矛盾仮定の 3 行も両証明の `rw [hab]`、`rw [hbs]`、`rw [hsr]` で確認する。

## 主張全体の有限標本検査

`check.sage` は行別検算に加え、$(a,b)\ne(0,0)$ の 4,416 組で
$\iota(a)+\iota(b)s\ne0$、移項の恒等変形 4,324 組、$b\ne0$ の逆元と有理数表示の鎖 4,324 組、
$b=0$ の係数消去 92 組を検査する。2026-10-04 の再実行は全件通過した。
これらの組数は行別の 43,761 等式へ加算しない。

2026-08-13 の記録も上記の主張全体の件数で通過している。
背理法の仮定は標本で実現せず、仮定代入の数値通過件数は含まれない。

## 実行方法

プロジェクト直下で実行する。

```sh
sage -c "__file__='sagemath/check/one-s-linearly-independent/check.sage'; load(__file__)"
```
