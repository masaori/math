# SageMath Check: end_preserves_matrix_exponential

## 対象

**対象ラベル**: `end_preserves_matrix_exponential` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/004_transfer_matrix.ts`
- ブロック: `transfer_matrix_005c_claim_end_preserves_matrix_exponential`（行列表示と線型写像表示は指数関数を保つ。`(end(exp A))(f) = lim_N Σ_{n≤N} (end(A)^n)(f)/n!`）
- 範囲: 中間目標「冪の保存」の基底と帰納の段、中間目標「部分和の書き換え」の鎖、主張の式変形の 4 行、主張そのもの

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 冪の保存の基底: `end(A^0) = end(I) = id_F = end(A)^0` | `check_power_preservation_and_partial_sum.sage` | `M = 1, 2` は `A`・`f` の成分を `QQ(i)` 上の独立な不定元に、`M = 3` は `A` を `QQ(i)` の具体の行列・`f` を不定元に置き、値 `(·)(f)` の等号で確かめる | **PASS** | 厳密等号 |
| 冪の保存の帰納の段: `end(A^{n+1}) = end(A^n A) = end(A^n)∘end(A) = end(A)^n∘end(A) = end(A)^{n+1}` | 同上 | `M = 1` は `n ≤ 5`、`M = 2` は `n ≤ 3`、`M = 3` は `n ≤ 2` の各段で 5 つの値を作る。第一の等号と第四の等号は定義の展開で、検算のコードでも同じ計算になる（計算は無い）。実際に確かめているのは第二の等号（`end` の乗法性）と第三の等号（帰納法の仮定）である。行列の冪は `A^{n+1} := A^n A`、線型写像の冪は主張の約束 `end(A)^{n+1} := end(A)^n∘end(A)` で作る | **PASS** | 厳密等号 |
| 部分和の書き換え: `S_N•f = (end S_N)(f) = (end(Σ A^n/n!))(f) = (Σ end(A^n)/n!)(f) = (Σ end(A)^n/n!)(f) = Σ (end(A)^n)(f)/n!` | 同上 | 同じ設定で `N ≤ 6`（`M = 1`）、`N ≤ 4`（`M = 2`）、`N ≤ 3`（`M = 3`）。`S_N•f` は `mat_mult` の和の式と Sage の積の両方で作る。第二の等号（`S_N` の定義の展開）は計算が無い | **PASS** | 厳密等号 |
| 主張の式変形の第一・第二の等号: `(end(exp A))(f) = (end S)(f) = S•f` | `check_limit_chain_and_statement.sage` | `M = 1, 2, 3` の `QQ(i)` の具体の `A`・`f` で、`exp(A)` を囲むボールの行列に `end`（定義の文言どおり）と `mat_mult` の積をそれぞれ施し、成分ごとに重なることを確かめる。第一の等号は `S := exp(A)` の置き換えで、計算は無い | **PASS** | 重なる |
| `S•f = (Σ_{m=0}^∞ A^m/m!)•f` | 同上 | `S := exp(A)` を `def_exp` (1) の級数に書き直す行で、計算は無い | — | — |
| `(Σ_{m=0}^∞ A^m/m!)•f = lim_N S_N•f` | 同上 | `N = 5, 20, 60, 120` で、`S_N•f - S•f` の距離を囲むボール（Arb のボール演算なので真の距離を含む）の下端が尾の評価 `2c^{N+1}/(N+1)!·‖f‖`（`‖B•f‖ ≤ ‖B‖‖f‖` は `matrix_norm_vector_bound`）以下で、ボールの半径が `2^{-300}` 未満であること | **PASS** | 成り立つ |
| 最後の等号: 二つの列は各 `N` で等しい | 同上 | `N = 5, 20, 60, 120` で、`S_N•f` と `Σ_{n≤N} (end(A)^n)(f)/n!`（`end(A)` を `n` 回施して作る）が `QQ(i)` で厳密に等しい | **PASS** | 厳密等号 |
| 主張そのもの | 同上 | `end(exp A)(f)` のボールが、`N = 120` の部分和 `Σ (end(A)^n)(f)/n!` を中心に尾の評価を半径にしたボールと重なる。ボールの中心はどちらも本文の部分和なので、これは部分和どうしの比較である。本文の定義とは独立な確認は、Arb の行列の exp による `exp(A)•f` と重なることで、これが主張の本体の確認である。対照として `exp(A^⊤)•f` とは重ならないこと | **PASS** | 成り立つ、対照は重ならない |

確かめられない行: `exp_converges` (1a) と極限の一意性（`matrix_norm_triangle_inequality` (4)）を当てはめる段は、無限列についての論理の段で、有限の計算に落ちない。その前後の値を確かめた。

対照（`check_power_preservation_and_partial_sum.sage`）: `end(A^2)(f)` は `end(A^⊤)^2(f)` と一致しない。

`end` は `_shared/end_by_definition.sage` が定義の文言どおりに作る（基底の座標は Sage の線型代数で求めるが、`end` の値が行列と数ベクトルの積に等しいという主張は使わない）。`end` の値が行列と数ベクトルの積に等しいこと自体は、
新しく足した主張 `end_agrees_with_matrix_vector_product` の検算（`sagemath/check/end_agrees_with_matrix_vector_product/`）が確かめる。

## 計算の帰属と範囲

- **厳密**: 係数は `QQ(i)`、不定元は `QQ(i)` 上の多項式環。冪の保存・部分和の書き換え・最後の等号は全て厳密。
- **`ℝ` への脱出（`ComplexBallField(512)`）**: `exp(A)` と `S•f`、`(end(exp A))(f)` の値だけ。極限で定まり `QQ(i)` に収まらないためである。
  ボールの中心は本文の部分和 `S_K`（`K` は既定で `max(150, ⌈8c⌉)`）、半径は尾の評価 `2c^{K+1}/(K+1)!`（`c` は `‖A‖` の有理数の上界 `Σ(|Re a|+|Im a|)`、`K + 2 ≥ 2c`）。
  各成分の誤差が `‖exp(A) - S_K‖` 以下であること、`‖A^m‖ ≤ ‖A‖^m`（`matrix_norm_submultiplicativity`）、比 1/2 の等比級数との比較による。
  この尾の評価は本文には無く、検算の側で導いた。許容誤差は置かず、ボールの重なりと、真の値を含むボールの下端と尾の評価の比較で判定する。
- 範囲外: `M ≥ 4`、選んだ以外の `A`・`f`。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh end_preserves_matrix_exponential end_agrees_with_matrix_vector_product
```

実行ログは `logs/` に保存する。
