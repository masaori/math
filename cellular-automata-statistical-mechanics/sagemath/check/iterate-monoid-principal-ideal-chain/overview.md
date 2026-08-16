# SageMath 検算: 反復モノイドの主イデアル同値と有限鎖

## 対象

**対象ラベル**: `claim_iterate_monoid_principal_ideal_equivalence_relation`

- 併せて検証するラベル: `claim_iterate_monoid_generated_ideals_comparable`、`claim_iterate_monoid_generated_ideal_finite_chain_decidable`
- 検証範囲: 生成主イデアルの等号による関係が同値関係であること、任意の二つの生成主イデアルが包含で比較できること、有限代表と合成表から相異なる生成主イデアル・包含関係・同値類を有限走査で決定できること
- 全数範囲: セル数 $0$ の唯一の大域写像、および $1\le |V|\le 3$ の巡回舞台上の全 256 初等 CA 規則（計 769 個の大域写像）

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_principal_ideal_equivalence.sage` | 全ての反復写像の組・三つ組について、主イデアルの等号が反射律・対称律・推移律を満たすこと | PASS | 769 写像・同値律 22,906 件で成立 |
| `check_generated_ideals_comparable.sage` | $J_F(F^m)=I_m(F)$ を確認し、$m\le n$ なら $J_F(F^n)\subseteq J_F(F^m)$、逆順なら逆包含となること | PASS | 769 写像・生成元の順序対 6,972 組で成立 |
| `check_finite_chain_decidability.sage` | 有限代表と合成表から主イデアルを列挙し、包含による全比較と主イデアル同値類の分割を有限走査で得ること | PASS | 769 写像・相異なる主イデアル 1,419 個・同値類 1,419 個で成立 |

## 限界と帰属

- 全数検査は上記の有限範囲に限られ、任意の有限舞台・任意の大域写像に対する証明ではない。一般の場合の根拠は構造化記述の人手証明である。
- $|V|=1,2,3$ では巡回舞台上の半径 1 の一様な初等 CA の全 256 真理値表を検査する。任意の非一様 CA の全数列挙とは主張しない。
- 全て有限集合上の写像を有限真理値表として表し、その等号、合成、有限部分集合の等号と包含、自然数の大小比較だけで厳密に検査する。浮動小数点と $\mathbb{R}/\mathbb{C}$ 脱出はない。

## 実行方法

```bash
for file in sagemath/check/iterate-monoid-principal-ideal-chain/check_*.sage; do sage "$file"; done
```
