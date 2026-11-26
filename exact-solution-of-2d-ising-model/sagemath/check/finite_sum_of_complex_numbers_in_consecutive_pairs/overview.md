# SageMath Check: finite_sum_of_complex_numbers_in_consecutive_pairs

## 対象

**対象ラベル**: `finite_sum_of_complex_numbers_in_consecutive_pairs` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/002_linear_space_general.ts`
- ブロック: `linear_space_general_000_claim_finite_sum_of_complex_numbers_in_consecutive_pairs`（複素数の偶数個の有限和は、隣り合う二項の和の有限和に等しい）
- 範囲: 主張 `Σ_{j=1}^{2n} z_j = Σ_{k=1}^{n} (z_{2k-1} + z_{2k})` と、証明の `n = 0` の 2 行・`n = 1` の 3 行・`n → n+1` の 7 行

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| `n = 0` の 2 行 | `check_induction_chain.sage` | 空の和 `Σ^{0} := 0_ℂ` で隣り合う行が等しい | **PASS** | 厳密等号 |
| `n = 1` の 3 行 | 同上 | `def_finite_sum_of_complex_numbers` どおり左から足した和で隣り合う行が等しい | **PASS** | 厳密等号 |
| `n → n+1` の 7 行 | 同上 | `n = 1,…,7` で帰納法の仮定を確かめ、隣り合う行が等しい | **PASS** | 厳密等号 |
| 主張そのもの | 同上 | Sage の `sum`（独立な経路）と比べる。否定コントロールとして、`z_{2n+2}` を落とした右辺とは一致しないことも確かめる | **PASS** | `n = 2,…,8` で厳密等号 |

## 計算の帰属と範囲

`z_j` を `QQ` 上の多項式環の不定元に置いた。不定元で成り立つ多項式の等号は、任意の複素数を代入しても成り立つ（代入は環準同型である）。
浮動小数点と `RR` / `CC` への脱出はない。一般の `n` は人手証明の帰納法が担う。和の結合律の行は Sage の正規形で吸収されるので、
この検査が確かめるのは各行に書かれた式（添字・括弧・項の並び）が前の行と同じ値を持つことである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh finite_sum_of_complex_numbers_in_consecutive_pairs
```

実行ログは `sagemath/check/finite_sum_of_complex_numbers_in_consecutive_pairs/logs/` に保存する（2026-11-25）。
