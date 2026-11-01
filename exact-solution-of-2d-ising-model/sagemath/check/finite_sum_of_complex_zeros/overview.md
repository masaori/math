# SageMath Check: finite_sum_of_complex_zeros

## 対象

**対象ラベル**: `finite_sum_of_complex_zeros` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_00_09.ts`
- ブロック: `calc_formulae_claim_finite_sum_of_complex_zeros`（複素数の零の有限和は零）

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| `m = 1` の 1 行 | `check_induction_chain.sage` | `def_finite_sum_of_complex_numbers` の和で組んだ値が `0_C` | **PASS** | 厳密等号 |
| `m → m+1` の 6 行 | 同上 | `m = 1,…,8` で隣り合う行が等しい。帰納法の仮定も各 `m` で確かめ、Sage の `QQ(i)` の和と比べた | **PASS** | 同上 |

## 計算の帰属と範囲

浮動小数点はない。ℂ は本文 `definition_of_cc` どおり実数の対で持ち（`_shared/complex_as_real_pairs.sage`）、成分は `QQ` で厳密に計算した。

## 確かめられない行と理由

各行は具体の値 `(0, 0)` の計算なので、定義を開く行（`def_finite_sum_of_complex_numbers`・`inclusion_rr_to_cc`・`definition_of_cc` の和）は同語反復である。一般の `m` は人手証明の帰納法が担う。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh finite_sum_of_complex_zeros
```

実行ログは `sagemath/check/finite_sum_of_complex_zeros/logs/` に保存する。
