# SageMath Check: epsilon_projector_commutes_with_epsilon_commuting_matrix

## 対象

**対象ラベル**: `epsilon_projector_commutes_with_epsilon_commuting_matrix`

- ファイル: `structured-latex/content/partition_function_projection_and_jordan_wigner.ts`
- ブロック: `bridge_claim_epsilon_projector_commutes_with_epsilon_commuting_matrix`（ε と可換な行列は P^{(+)} とも可換）
- 範囲: 証明の全ての行と主張

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 9 等号の鎖 | `check_chain.sage` | 各行を括弧の形どおりに本文の定め方（`mat_mult`・`def_matrix_sum`・`def_matrix_scalar_multiple`・`def_identity_matrix` の成分の式）で組み、隣の行と比べる。X は εX = Xε を満たす一般の行列 X := Y + εYε（Y の成分は独立な不定元）。M_col = 1..3。対照: X を独立な不定元の行列にすると、仮定を使う第 5→6 行だけが崩れる | **PASS** | 成り立つ |
| 主張 | `check_claim.sage` | ε と可換な行列の空間（XE − EX = 0 の解空間。Sage の `right_kernel` で求め、次元が 2(n/2)^2 であることも確かめる）の基底のすべてで P^{(+)}X = XP^{(+)} を Sage の `*` で確かめる。M_col = 1..4 | **PASS** | 成り立つ |

ε は本文の定め方（`def_global_spin_flip_matrix` の σ_1^x⋯σ_M^x を `def_kronecker` の成分の式と `mat_mult` の成分の式で組んだもの）と Sage の `tensor_product`・`*` の二経路で作って一致を確かめてから使い、`P^{(+)} = (1/2)(I+ε)` も本文の定め方と Sage の `+`・`/` の二経路で作る（共通の準備 `sagemath/_shared/epsilon_projector_exact.sage`）。

## 計算の帰属と範囲

- **厳密**: 成分はすべて `QQ(i)` かその上の多項式環で、浮動小数点と ℝ/ℂ への脱出はない。
- 範囲外: M_col ≥ 4 の鎖、M_col ≥ 5 の主張。鎖の各行は M_col に依らない行列の演算の主張を一つずつ使うだけである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh epsilon_projector_commutes_with_epsilon_commuting_matrix
```

実行ログは `logs/` に保存する。
