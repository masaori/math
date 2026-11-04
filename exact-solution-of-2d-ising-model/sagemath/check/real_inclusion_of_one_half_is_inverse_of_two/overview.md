# SageMath Check: real_inclusion_of_one_half_is_inverse_of_two

## 対象

**対象ラベル**: `real_inclusion_of_one_half_is_inverse_of_two` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_20_29.ts`
- ブロック: `calc_formulae_claim_real_inclusion_of_one_half_is_inverse_of_two`（(1/2)_ℂ = 2_ℂ^{-1}）
- 範囲: 主張と、証明の七つの等号（八つの項）の鎖

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 鎖の七つの等号（単位元、逆元、結合律、`real_inclusion_preserves_product`、ℝ の 1/2·2 = 1、1_ℂ の略記、単位元） | `check_chain.sage` | ℂ を `QQ` の対として持ち、各項を `definition_of_cc` の積で別々に作って隣り合う項を比べる。2_ℂ^{-1} は `definition_of_cc` の積の式で作った 2_ℂ w = 1_ℂ を解いて作る（逆元の値を先に置かない）。対照として (1/3)_ℂ ≠ 2_ℂ^{-1}、2_ℂ(1/2, 1) ≠ 1_ℂ | **PASS** | 等号 7 個、否定コントロール 2 件 |

## 計算の帰属と範囲

成分はすべて `QQ` で、浮動小数点はない。主張は具体的な二つの数についてなので、範囲の制限は無い。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh real_inclusion_of_one_half_is_inverse_of_two
```

実行ログは `logs/` に保存する。
