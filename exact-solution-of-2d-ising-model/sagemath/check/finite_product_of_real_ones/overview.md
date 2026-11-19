# SageMath Check: finite_product_of_real_ones

## 対象

**対象ラベル**: `finite_product_of_real_ones` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_20_29.ts`
- ブロック: `calculation_formulae_claim_finite_product_of_real_ones`（実数の 1 の有限積は 1）
- 範囲: 主張と、帰納法の二つの鎖

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| `m = 1` の行と、`m → m+1` の三行（定義の帰納の式・帰納法の仮定・ℝ の乗法の単位元 `p·1 = p`） | `check_induction_lines.sage` | 有限積を `def_finite_product_of_real_numbers` の帰納法どおり左から掛ける経路と Sage の `prod` の経路で作り、各行の等号と帰納法の仮定を確かめる。対照として、1 でない因子があれば 1 にならないこと | **PASS** | `m = 1,…,20` |

## 計算の帰属と範囲

`QQ` の 1 で厳密に確かめた。浮動小数点はない。一般の `m` は人手証明の帰納法が担う。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh finite_product_of_real_ones
```
