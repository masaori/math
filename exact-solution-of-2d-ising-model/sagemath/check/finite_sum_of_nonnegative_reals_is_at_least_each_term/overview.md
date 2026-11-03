# SageMath Check: finite_sum_of_nonnegative_reals_is_at_least_each_term

## 対象

**対象ラベル**: `finite_sum_of_nonnegative_reals_is_at_least_each_term` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_00_09.ts`
- ブロック: `calc_formulae_claim_finite_sum_of_nonnegative_reals_is_at_least_each_term`（非負の実数の有限和は各項以上）
- 範囲: 主張 `a_j ≥ 0（すべての j）⇒ Σ_{j=1}^{m} a_j ≥ a_k（すべての k）` と、証明の帰納法の各行

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| `m = 1` の 2 行 | `check_induction_chain.sage` | `def_finite_sum_of_real_numbers` どおり `Σ_{j=1}^{1}a_j = a_1 = a_k` | **PASS** | 厳密等号 |
| `k ≤ m` の 4 行 | 同上 | 和の定義の展開と `0` の単位元の 2 行は多項式環の恒等式として、`≥` の 2 行（`a_{m+1} ≥ 0` を足す、帰納法の仮定）は 0 以上の有理数の組で | **PASS** | 厳密 |
| `k = m+1` の前置きの 2 行と 4 行 | 同上 | 前置き `Σ_{j=1}^{m}a_j ≥ a_1 ≥ 0`、和の定義の展開、`Σ_{j=1}^{m}a_j ≥ 0` を足す行、`0` の単位元、`k = m+1` | **PASS** | 厳密 |
| 主張そのもの | 同上 | 左から足した和と Sage の `sum` の両方で `≥ a_k`。否定コントロールとして、負の項を含む `(−1, 1)` では `Σ < a_2` になることを確かめる | **PASS** | `m = 1,…,8`、各 30 組（`0` を含む）、全ての `k` |

等号は合わせて 2392 行、不等号は 2310 行を確かめた。さらに、不等号の各行の両辺の差が、仮定で 0 以上とされる量（`a_{m+1}`、`a_k` 以外の項の和、`Σ_{j=1}^{m} a_j`、`a_2,…,a_m` の和）に恒等的に一致することを多項式環で 49 本確かめた（標本に頼らない確認）。

## 計算の帰属と範囲

等号の行は `a_j` を `QQ` 上の多項式環の不定元に置き、恒等式として確かめた。不等号の行は `QQ` の 0 以上の元の組で厳密に確かめた（乱数の種は固定）。
浮動小数点と `RR` / `CC` への脱出はない。一般の `m` と一般の実数は人手証明の帰納法が担う。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh finite_sum_of_nonnegative_reals_is_at_least_each_term
```

実行ログは `sagemath/check/finite_sum_of_nonnegative_reals_is_at_least_each_term/logs/` に保存する（2026-11-03）。
