# SageMath Check: finite_sum_of_real_numbers_is_invariant_under_bijective_reindexing

## 対象

**対象ラベル**: `finite_sum_of_real_numbers_is_invariant_under_bijective_reindexing` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_00_09.ts`
- ブロック: `calc_formulae_claim_finite_sum_of_real_numbers_is_invariant_under_bijective_reindexing`
  （実数の有限和は添字の全単射による付け替えで変わらない）
- 範囲: `m = 1` の段の 3 行の鎖、`m → m+1` の段の 7 行の鎖、帰納法の仮定に当たる等号

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| `m = 1` の 3 行 | `check_reindexing_induction_chain.sage` | `π(1) = 1` と 4 本の列で、`Σ a_{π(j)} = a_{π(1)} = a_1 = Σ a_j` の各等号 | **PASS** | 有限の全数検査 |
| `m → m+1` の 7 行 | 同上 | `m+1 = 2,…,6` の `{1,…,m+1}` の全ての置換 `π`（872 個）と各 4 本の列で、`π(k) = m+1` の `k`、`b_j := a_{π(j)}`、`τ^π_k` を作り、隣り合う行の等号を全て確かめる | **PASS** | 有限の全数検査 |
| 帰納法の仮定 | 同上 | 同じ組で `Σ_{j=1}^{m} a_{τ^π_k(j)} = Σ_{j=1}^{m} a_j` を独立に計算し、`τ^π_k` の値の並べ替えが `1,…,m` に一致する | **PASS** | 同上 |
| 否定コントロール | 同上 | 値が相異なる列で、`π(k') ≠ m+1` の `k'` を `k` の代わりに使って作った式 `Σ_{j=1}^{m} a_{π(δ^m_{k'}(j))} + a_{m+1}` が、最後の値 `Σ_{j=1}^{m+1} a_j` と一致しない | **PASS** | 13064 件 |

鎖の段は全体で 24428 段、置換と列の組は 3492 組である。

## 計算の帰属と範囲

添字は `ZZ` の元で、本文と同じ 1 始まりで書いた。`a_j` は `ℝ` の元の代表として `QQ` の元を使い、有限和は
`def_finite_sum_of_real_numbers` どおり左から足す。浮動小数点と `RR` / `CC` への脱出はない。
一般の `m` と一般の実数は人手証明が担い、この検算は `m ≤ 6` の全数検査で書き間違いを検出する。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh finite_sum_of_real_numbers_is_invariant_under_bijective_reindexing
```

実行ログは `sagemath/check/finite_sum_of_real_numbers_is_invariant_under_bijective_reindexing/logs/` に保存する（2026-11-06）。
