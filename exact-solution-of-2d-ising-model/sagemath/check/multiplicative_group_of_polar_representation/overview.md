# SageMath Check: multiplicative_group_of_polar_representation

## 対象

**対象ラベル**: `multiplicative_group_of_polar_representation` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_20_29.ts`
- ブロック: `calculation_formulae_023_claim_multiplicative_group_of_polar_representation`（（極座標表現）の乗法群）
- 範囲: 主張（`(極座標表現)^×` が群をなす）と、証明の段（積で閉じること、単位元を含むこと、逆元をもつこと、結論）

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 積で閉じること（`r,r' ≠ 0 ⟹ r,r' > 0 ⟹ rr' > 0 ⟹ rr' ≠ 0`、`[(r,θ)]·[(r',θ')] = [(rr',θ+θ')] ≠ [(0,0)]`）、単位元を含むこと（`e ≠ [(0,0)]`）、逆元をもつこと（`1/r ≠ 0` と `[(1/r,-θ)] ∈ (極座標表現)^×`） | `check_closure_and_inverse_membership.sage` | 具体の点で各行。対照として、半径が零の元を因子にもつ積は `[(0,0)]` に入ること | **PASS** | 49 組と 7 元 |
| 主張と結論の段 | `check_statement.sage` | 具体の非零の元の上で、積での閉性・結合律・単位元・`(極座標表現)^×` の中の逆元の存在。`[(0,0)]` が逆元を持たないこと | **PASS** | 7 元（積で閉じること 49 組、結合律 343 組） |

## 計算の帰属と範囲

浮動小数点と `RR` / `CC` への脱出はない。共通の準備は `sagemath/_shared/polar_representation.sage`。

- **具体の点**: 半径は `AA`（実代数的数）の非負の元（`0`、`1`、`2`、`1/5`、`√2`、`∛3`、`10^6`）。
  角度は `a + bπ`（`a, b ∈ QQ`）の形の実数で、`QQ` 上の一変数多項式環の一次以下の元として持つ。
  `π` は無理数なので `a + bπ = a' + b'π ⟺ (a,b) = (a',b')` であり、角度の等号・和・差・符号反転と、
  角度の同値 `θ ∼_angle θ' ⟺ ∃ n ∈ Z, θ-θ' = 2nπ`（差の定数項が `0` で `π` の係数の半分が整数）が厳密に判定できる。
  極座標表現の同値は定義 `polar_equivalence_class` の式どおり `r = r' = 0 ∨ (r = r' ∧ θ ∼_angle θ')` で判定し、
  類の等号はこの判定で確かめた。

主張の半径・角度は `R` の元であり、`AA` や `a + bπ` に入らない点は検算の範囲外で、人手証明が担う。

積の鎖の最初の行（積の定義）は、本文の行が定義どおりに写されているかの確認に留まる。
結合律・単位元・逆元の存在はそれぞれ `monoid_of_polar_representation`・`inverse_in_polar_representation` の検算が確かめる。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh multiplicative_group_of_polar_representation
```

実行ログは `sagemath/check/multiplicative_group_of_polar_representation/logs/` に保存する。
