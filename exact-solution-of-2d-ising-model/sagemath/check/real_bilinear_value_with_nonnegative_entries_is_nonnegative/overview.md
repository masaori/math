# SageMath Check: real_bilinear_value_with_nonnegative_entries_is_nonnegative

## 対象

**対象ラベル**: `real_bilinear_value_with_nonnegative_entries_is_nonnegative` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/011_max_eigenvalue.ts`
- ブロック: `maxeig_claim_real_bilinear_value_with_nonnegative_entries_is_nonnegative`（成分が非負の実数の行列と、成分が非負の二つの実数のベクトルについて、`x^T P y` は非負である）
- 主張は `x^T P y ≥ 0`（`P_kl ≥ 0`、`x_k ≥ 0`、`y_l ≥ 0`）。`x^T P y` は定義 `def_real_bilinear_value`（`Σ_k Σ_l (x_k P_kl) y_l`、左から順に足す）どおりに成分から組む。

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 準備の 2 つの不等式（項の非負性） | `check_nonnegativity_chain.sage` | 各 `p, q` で `x_p P_pq ≥ 0`、`(x_p P_pq) y_q ≥ 0` | **PASS** | 厳密（`QQ`） |
| 行の和の非負性の 2 行の鎖 | 同上 | 各 `p` で `Σ_l (x_p P_pl) y_l ≥ (x_p P_p1) y_1 ≥ 0` | **PASS** | 同上 |
| 本体の 3 行の鎖 | 同上 | `x^T P y = Σ_k Σ_l (x_k P_kl) y_l ≥ Σ_l (x_1 P_1l) y_l ≥ 0` | **PASS** | 同上 |
| 主張そのもの | 同上 | 左端を Sage の `vector * matrix * vector`（独立な経路）と比べる。否定コントロールとして、負の成分を許すと主張が成り立たないことを確かめる | **PASS** | 同上 |

`n = 1,…,5` を各 40 組、成分を非負の有理数に取った 200 組で、計 6200 段を確かめた（乱数の種 `20261107`）。

## 計算の帰属と範囲

成分は `QQ` の非負の元である。浮動小数点と `RR` / `CC` への脱出はない。
不等式は有限個の具体例でしか確かめられないので、一般の非負の実数については人手証明の鎖が担う。
この検査が確かめるのは、各行に書かれた式（添字の位置、選ぶ項 `k → 1`・`p → 1`・`q → 1`、外側と内側の和の分け方）が前の行との大小を満たすことである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh real_bilinear_value_with_nonnegative_entries_is_nonnegative
```

実行ログは `sagemath/check/real_bilinear_value_with_nonnegative_entries_is_nonnegative/logs/` に保存する（2026-11-07）。
