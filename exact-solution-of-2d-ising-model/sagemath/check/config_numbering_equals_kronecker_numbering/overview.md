# SageMath Check: config_numbering_equals_kronecker_numbering

## 対象

**対象ラベル**: `config_numbering_equals_kronecker_numbering` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/004_transfer_matrix.ts`
  （ブロック `transfer_matrix_claim_config_numbering_equals_kronecker_numbering`）
- 範囲: statement `ord(μ) = ν(ι(μ))` と proof の全段
  （各 `m` で `i_m - 1 = (1-μ(m))/2`、`ν(ι(μ)) = 1 + Σ(i_m-1)2^{M-m} = 1 + Σ (1-μ(m))/2 · 2^{M-m} = ord(μ)`）
- 併せて使う定義: `def_row_configuration_numbering`（`ord`）、`def_kronecker`（`ν` と `⊠` の成分定義）、
  `def_config_basis_iso`（`ι`）

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
|---------|---------|-----------|------|
| check_ord_equals_nu_iota.sage | 主張の式変形の各段（`M_col = 1..12`、全 μ） | PASS | 全 μ で一致 |
| check_nu_is_standard_kronecker_order.sage | 補助: `def_kronecker` の成分定義どおりに作った `⊠` が Sage の `tensor_product` と一致すること（乱数の整数行列、`M = 1..5`）、`f_{ι(μ)} = e_{i_1}⊠…⊠e_{i_M}` が第 `ord(μ)` 標準基底ベクトルであること | PASS | 全ケース一致 |

## 備考

- すべて `ZZ` / `QQ` の厳密計算。ℝ 脱出なし。
- 補助のチェックは主張そのものではなく、検証側の土台（`kron_by_definition` と `tensor_product` の並びが
  `def_kronecker` の `ν` に一致すること）を確かめるもの。`first_transfer_matrix_pauli_form/`・
  `second_transfer_matrix_pauli_form/`・`043_claim_transfer_matrix_bridge/` はこの並びに依存している。
- 乱数の種は `20260926` に固定した。

## 実行方法

```bash
cd sagemath/check/config_numbering_equals_kronecker_numbering
for f in check_*.sage; do sage "$f"; done
```

実行ログは `logs/` に保存してある（2026-09-26、SageMath 10.9）。
