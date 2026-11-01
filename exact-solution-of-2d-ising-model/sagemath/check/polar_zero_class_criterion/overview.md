# SageMath Check: polar_zero_class_criterion

## 対象

**対象ラベル**: `polar_zero_class_criterion` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_20_29.ts`
- ブロック: `calculation_formulae_claim_polar_zero_class_criterion`（極座標表現の元が半径零の類に等しいことの判定）
- 範囲: 主張 `[(r,θ)] = [(0,0)] ⟺ r = 0`

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 主張 | `check_criterion.sage` | 具体の点で、標本と同値な別の代表元の全てについて、同値の判定と `r = 0` が一致すること。対照として、半径が `10^{-9}` で角度が `0` の元は `[(0,0)]` でないこと | **PASS** | 34 個の代表元 |

## 計算の帰属と範囲

浮動小数点と `RR` / `CC` への脱出はない。共通の準備は `sagemath/_shared/polar_representation.sage`。

- **具体の点**: 半径は `AA`（実代数的数）の非負の元（`0`、`1`、`2`、`1/5`、`√2`、`∛3`、`10^6`）。
  角度は `a + bπ`（`a, b ∈ QQ`）の形の実数で、`QQ` 上の一変数多項式環の一次以下の元として持つ。
  `π` は無理数なので `a + bπ = a' + b'π ⟺ (a,b) = (a',b')` であり、角度の等号・和・差・符号反転と、
  角度の同値 `θ ∼_angle θ' ⟺ ∃ n ∈ Z, θ-θ' = 2nπ`（差の定数項が `0` で `π` の係数の半分が整数）が厳密に判定できる。
  極座標表現の同値は定義 `polar_equivalence_class` の式どおり `r = r' = 0 ∨ (r = r' ∧ θ ∼_angle θ')` で判定し、
  類の等号はこの判定で確かめた。

主張の半径・角度は `R` の元であり、`AA` や `a + bπ` に入らない点は検算の範囲外で、人手証明が担う。

証明の (⇐)・(⇒) の各行は、定義 `polar_equivalence_class` の二つの選言を読み替えるだけで、検算として独立に確かめる計算を含まない。検算は主張の判定だけを確かめる。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh polar_zero_class_criterion
```

実行ログは `sagemath/check/polar_zero_class_criterion/logs/` に保存する。
