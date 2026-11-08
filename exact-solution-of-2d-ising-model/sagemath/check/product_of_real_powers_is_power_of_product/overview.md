# SageMath Check: product_of_real_powers_is_power_of_product

## 対象

**対象ラベル**: `product_of_real_powers_is_power_of_product` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_20_29.ts`
- ブロック: `calculation_formulae_claim_product_of_real_powers_is_power_of_product`（同じ指数の実数の冪の積は積の冪に等しい）
- 範囲: 主張 `a^m b^m = (ab)^m` と、証明の帰納法の各行

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| `m = 0` の 3 行 | `check_induction_chain.sage` | `a^0 b^0` → `1·1` → `1` → `(ab)^0`（冪は `def_power_of_real_number` どおり `a^0 := 1`、`a^{m+1} := a^m a` で組む） | **PASS** | 厳密 |
| `m → m+1` の 4 行（帰納法の仮定を含む） | 同上 | `m = 0,…,8` で帰納法の仮定 `a^m b^m = (ab)^m` と 4 行の等号を確かめ、Sage の `**`（独立な経路）と比べる | **PASS** | 厳密（38 組の `(a, b)` で等号 1482 個） |
| `def_sector_rayleigh_sup` の当て方 | 同上 | `(1/√2)^M(1/√2)^M = (1/√2·1/√2)^M = (1/2)^M`、`2^M(1/2)^M = 1^M = 1` | **PASS** | `AA` で厳密 |
| 否定コントロール | 同上 | 帰納法の段の 2 行目で `ab` の代わりに `a + b` を掛けると等号が崩れる | **PASS** | 36 件 |

## 計算の帰属と範囲

`a, b` は `QQ` の 6 値（`0`、`±1`、正負の分数、整数）の全 36 組と、`def_sector_rayleigh_sup` が当てる `(1/√2, 1/√2)`・`(2, 1/2)`（`AA`、実代数的数）である。
等号は厳密に判定し、浮動小数点と `RR` / `CC` への脱出はない。一般の実数と一般の `m` は人手証明の帰納法が担う。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh product_of_real_powers_is_power_of_product
```

実行ログは `sagemath/check/product_of_real_powers_is_power_of_product/logs/` に保存する（2026-11-08、SageMath 10.9）。
