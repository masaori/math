# SageMath Check: power_of_real_one_is_one

## 対象

**対象ラベル**: `power_of_real_one_is_one` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_20_29.ts`
- ブロック: `calculation_formulae_claim_power_of_real_one_is_one`（実数の 1 の冪は 1）
- 範囲: 主張 `1^m = 1` と、証明の帰納法の各行

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| `m = 0` の 1 行 | `check_induction_chain.sage` | `1^0 = 1`（冪は `def_power_of_real_number` どおり `a^0 := 1`、`a^{m+1} := a^m a` で組む） | **PASS** | 厳密 |
| `m → m+1` の 3 行（帰納法の仮定を含む） | 同上 | `m = 0,…,20` で帰納法の仮定 `1^m = 1` と `1^{m+1} = 1^m·1 = 1·1 = 1` を確かめ、Sage の `**` と比べる | **PASS** | 厳密（等号 128 個） |
| 否定コントロール | 同上 | 底を `1` 以外（`2`、`-1/3`、`1/√2`）にすると `m ≥ 1` で `1` にならない | **PASS** | 60 件 |

## 計算の帰属と範囲

`1 ∈ QQ` と `1 ∈ AA` で厳密に判定する。浮動小数点と `RR` / `CC` への脱出はない。一般の `m` は人手証明の帰納法が担う。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh power_of_real_one_is_one
```

実行ログは `sagemath/check/power_of_real_one_is_one/logs/` に保存する（2026-11-08、SageMath 10.9）。
