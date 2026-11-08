# SageMath Check: finite_product_of_constant_real_is_power

## 対象

**対象ラベル**: `finite_product_of_constant_real_is_power` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_20_29.ts`
- ブロック: `calculation_formulae_claim_finite_product_of_constant_real_is_power`（実数の定数の有限積は冪に等しい）
- 範囲: 主張 `Π_{j=1}^{m} r = r^m` と、証明の帰納法の各行

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| `m = 1` の 4 行 | `check_induction_chain.sage` | `def_finite_product_of_real_numbers` どおり左から掛けた積 → `r` → `1r` → `r^0 r` → `r^1`（冪は `def_power_of_real_number` どおり `a^0 := 1`、`a^{m+1} := a^m a` で組む） | **PASS** | 厳密 |
| `m → m+1` の 3 行（帰納法の仮定を含む） | 同上 | `m = 1,…,8` で帰納法の仮定 `Π_{j=1}^{m} r = r^m` と 3 行の等号を確かめ、Sage の `**`（独立な経路）と比べる | **PASS** | 厳密（7 通りの `r` で等号 196 個） |
| `def_sector_rayleigh_sup` の当て方 | 同上 | `m → M_col`、`r → 1/√2` で `Π = (1/√2)^M` と `((1/√2)^M)^2 = 2^{-M}` | **PASS** | `AA` で厳密 |
| 否定コントロール | 同上 | 帰納法の段の 3 行目を `r^m` に取り違えると、`r ∉ {0, 1}` では等号が崩れる | **PASS** | 32 件 |

## 計算の帰属と範囲

`r` は `QQ` の 6 値（`0`、`±1`、正負の分数、整数）と、`def_sector_rayleigh_sup` が当てる `1/√2 ∈ AA`（実代数的数）である。
等号はどちらも厳密に判定し、浮動小数点と `RR` / `CC` への脱出はない。一般の実数と一般の `m` は人手証明の帰納法が担う。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh finite_product_of_constant_real_is_power
```

実行ログは `sagemath/check/finite_product_of_constant_real_is_power/logs/` に保存する（2026-11-08、SageMath 10.9）。
