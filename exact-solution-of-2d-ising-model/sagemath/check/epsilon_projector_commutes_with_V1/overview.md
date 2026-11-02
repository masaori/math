# SageMath Check: epsilon_projector_commutes_with_V1

## 対象

**対象ラベル**: `epsilon_projector_commutes_with_V1`

- ファイル: `structured-latex/content/partition_function_projection_and_jordan_wigner.ts`
- ブロック: `bridge_claim_epsilon_projector_commutes_with_V1`（P^{(+)} は V_1 と可換）
- 範囲: 証明の全ての行と主張

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 1 行の等号（一般の主張を X → V_1 で適用。仮定は `epsilon_commutes_with_V1`） | `check_claim_from_components.sage` | V_1 を `def_transfer_matrix` の成分の式で組み、exp(K_1 n)（n = −M..M）を独立な不定元に置いて、適用の仮定 εV_1 = V_1ε と主張 P^{(+)}V_1 = V_1P^{(+)} を厳密に確かめる。M_col = 1..5。対照: P^{(+)} を (1/2)(I + σ_1^x) に替えると成り立たない（M_col ≥ 2。M_col = 1 の V_1 はスカラー行列 w_1 I であることを確かめる） | **PASS** | 成り立つ |

ε は本文の定め方（`def_global_spin_flip_matrix` の σ_1^x⋯σ_M^x を `def_kronecker` の成分の式と `mat_mult` の成分の式で組んだもの）と Sage の `tensor_product`・`*` の二経路で作って一致を確かめてから使い、`P^{(+)} = (1/2)(I+ε)` も本文の定め方と Sage の `+`・`/` の二経路で作る（共通の準備 `sagemath/_shared/epsilon_projector_exact.sage`）。

## 計算の帰属と範囲

- **厳密**: 成分はすべて `QQ(i)` 上の多項式環で、exp(K_1 n) の値を不定元に置くので exp の評価（ℝ への脱出）を含まない。不定元に置いても成り立つので、K_1 ∈ ℝ_{>0} のどの値でも成り立つ。
- 範囲外: M_col ≥ 6。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh epsilon_projector_commutes_with_V1
```

実行ログは `logs/` に保存する。
