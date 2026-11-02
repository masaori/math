# SageMath Check: real_inclusion_preserves_product

## 対象

**対象ラベル**: `real_inclusion_preserves_product` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_00_09.ts`
- ブロック: `calc_formulae_claim_real_inclusion_preserves_product`（実数の積の包含は包含の積に等しい）
- 範囲: 主張 `a_C b_C = (ab)_C` と、証明の六つの項の鎖

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 鎖の五つの等号 | `check_chain.sage` | `a, b` を `QQ` の不定元に置き、ℂ を実数の対として持って、鎖の各項を別の式で作る。独立な経路として `QQ(i)[A,B]` の積の実部・虚部も読む。対照として、虚部が 0 でない数の積は実部が積にならないこと | **PASS** | 厳密等号 |

## 計算の帰属と範囲

不定元の多項式の等号は厳密に決まり、任意の実数を代入しても保たれる（代入は環準同型である）。浮動小数点はない。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh real_inclusion_preserves_product
```
