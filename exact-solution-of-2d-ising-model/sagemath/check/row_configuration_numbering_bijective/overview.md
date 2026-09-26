# SageMath Check: row_configuration_numbering_bijective

## 対象

**対象ラベル**: `row_configuration_numbering_bijective` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/001_partition_function_2d_ising.ts`
  （ブロック `partition_function_2d_ising_claim_row_configuration_numbering_bijective`）
- 範囲: statement（`ord : 𝔐 → {1,…,2^{M_col}}` は全単射）と proof の全段
  （準備の等比和・値域・単射性の評価・全単射性）
- 併せて使う定義: `def_row_configurations`（`𝔐`）、`def_row_configuration_numbering`（`ord`）

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
|---------|---------|-----------|------|
| check_geometric_sum.sage | 準備 `Σ_{t=0}^{n-1} 2^t = 2^n - 1` と帰納法の 4 段（`n = 0..40`） | PASS | 全段一致 |
| check_range_of_ord.sage | 値域の鎖 `0 ≤ Σ b_m 2^{M-m} ≤ Σ 2^{M-m} = Σ_{t<M} 2^t = 2^M - 1`、`1 ≤ ord(μ) ≤ 2^{M_col}`（`M_col = 1..12`、全 μ） | PASS | 全 μ で成立 |
| check_injectivity_estimate.sage | 単射性の証明の差の式変形 3 段と評価の鎖 `|R| ≤ … = 2^{M-k}-1 < 2^{M-k}`、差 ≠ 0（`M_col = 1..7`、`μ(k)=-1, μ'(k)=1` の向きの全組） | PASS | 全組で成立（`M_col = 7` で 8128 組） |
| check_bijective.sage | `|𝔐| = 2^{M_col}`、像が `{1,…,2^{M_col}}` 全体、重複なし、2 進展開による逆写像と互いに逆（`M_col = 1..12`） | PASS | 全 `M_col` で成立 |

## 備考

- すべて `ZZ` / `QQ` の厳密計算。浮動小数点は使っていない（ℝ 脱出なし）。
- `b_m(μ) = (1-μ(m))/2` は `QQ` で計算し、`ZZ` に属して `{0,1}` の値であることを毎回 assert している。
- 共通の定義（`ord_number`, `ord_inverse`, `row_configurations`）は `sagemath/_shared/row_configurations.sage`。
- 有限個の `M_col` についての確認であり、証明の代わりではない。

## 実行方法

```bash
cd sagemath/check/row_configuration_numbering_bijective
for f in check_*.sage; do sage "$f"; done
```

実行ログは `logs/` に保存してある（2026-09-26、SageMath 10.9。表の結果はそのログから取った）。
