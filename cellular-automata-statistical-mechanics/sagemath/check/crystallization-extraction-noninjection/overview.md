# SageMath 検算: 結晶化抽出とスカラー規格化の非単射性

## 対象

**対象ラベル**: `claim_crystallization_extraction_not_injective`

- 二元の有限基底と整数指数表を固定し、$q=0$ での係数評価、基底全単射、整数指数の抽出を別々に検査する。
- 相異なる二つの作用素 $\mathcal R$ と $(1+q)\mathcal R$ が同じ有限表と整数値表へ抽出されることを検査する。

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_coefficient_evaluation.sage` | $1+q$ の単元性、$q=0$ での評価、使用係数上の積の保存 | PASS | 正則な 4 係数で積の保存、単元と逆元の評価がともに 1 |
| `check_basis_bijection.sage` | 評価後の基底対応と有限全単射 | PASS | 二元基底対の全 4 入力で一意、像は全 4 基底対 |
| `check_integer_exponent_extraction.sage` | Laurent 単項式から抽出する整数指数と指定表の一致 | PASS | 全 4 入力で係数 1、整数指数 $-1,0,1,2$ が一致 |
| `check_scalar_normalization_noninjectivity.sage` | 異なる二同型の評価像と抽出結果の一致 | PASS | 2 同型は相異なり、評価行列は一致、8 個の基底・指数成分が一致 |

## 範囲と限界

- 検算は複素係数環の有理係数部分環 $\mathbb Q(q)[z,z^{-1}]$ にある明示例を使う。本文の一般証明を代用せず、非単射性に必要な一つの有限反例だけを厳密に検査する。
- $q=0$ は有理関数の分母が零でないことを確認した代数的評価であり、解析的極限ではない。
- 全ての等号を有理数、有理関数、Laurent 多項式、整数指数で判定する。浮動小数点、複素対数、除算による指数抽出、解析的極限は使わない。
- 一つの有限抽出表から任意の量子 $R$、複素 Bethe 根、固有ベクトル、転送行列スペクトルを復元できるとは主張しない。

## 実行方法

```bash
for file in cellular-automata-statistical-mechanics/sagemath/check/crystallization-extraction-noninjection/check_*.sage; do sage "$file"; done
```
