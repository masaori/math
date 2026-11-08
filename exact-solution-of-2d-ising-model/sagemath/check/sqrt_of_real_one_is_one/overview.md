# SageMath Check: sqrt_of_real_one_is_one

## 対象

**対象ラベル**: `sqrt_of_real_one_is_one` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_20_29.ts`
- ブロック: `calculation_formulae_claim_sqrt_of_real_one_is_one`（1 の平方根は 1）
- 範囲: 主張 `√1 = 1` と、証明の各行

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| `1^2 = 1`（`power_of_real_one_is_one`（`m → 2`）） | `check_proof_lines.sage` | 冪を `def_power_of_real_number` どおり `a^0 := 1`、`a^{m+1} := a^m a` で組み、`1^2 = 1` | **PASS** | 厳密（等号 2 個） |
| `y → 1` が `y ≥ 0 ∧ y^2 = 1` を満たし、そのような `y` はただ一つ（`definition_of_sqrt_r_positive`（`x → 1`）） | 同上 | `1 ≥ 0` と `1^2 = 1`、`y^2 − 1` の `AA` の根のうち非負のものが `1` だけであること、Sage の `sqrt` で `√1 = 1` | **PASS** | 厳密（等号 4 個。表の等号は合わせて 6 個） |
| 否定コントロール | 同上 | `0`・`2`・`1/2`・`√2` は `y^2 = 1` を満たさない。非負の条件を落とすと `−1` も満たす | **PASS** | 5 件 |

## 計算の帰属と範囲

`1 ∈ QQ` と `1 ∈ AA` で厳密に判定する。浮動小数点と `RR` / `CC` への脱出はない。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh sqrt_of_real_one_is_one
```

実行ログは `sagemath/check/sqrt_of_real_one_is_one/logs/` に保存する（2026-11-08、SageMath 10.9）。
