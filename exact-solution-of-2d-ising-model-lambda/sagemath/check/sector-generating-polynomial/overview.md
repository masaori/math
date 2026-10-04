# SageMath Check: セクターごとの生成多項式と、低温展開の自明セクター表示

## 対象

**対象ラベル**: `claim_low_temperature_trivial_sector_expression`

- 併せて検証: `def_sector_generating_polynomial`
- 範囲: 四つのセクターの生成多項式 $G^{a,b}_L\in\mathbb{Z}[x]$ を全辺部分集合の数え上げで作り、$D_L=G^{0,0}_L$ と $Z_L=2G^{0,0}_L$、および双対像が元の個数を保つこと（$|\delta_L(B)|=|B|$）を厳密検査する

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
|---|---|---|---|
| `check.sage` | $L=1,2,3$ について、$G^{a,b}_L$ を `ZZ[x]` で数え上げ、全配位からの $Z_L$・$D_L$ と突き合わせて $D_L=G^{0,0}_L$ と $Z_L=2G^{0,0}_L$ を厳密検査する | PASS | 全件一致 |
| `check_image_definition.sage` | $\Delta_L$ の像の集合を $\delta_L$ の像で書く | PASS | 格子サイズ3件 |
| `check_image_trivial_sector.sage` | 双対像全体を、全辺部分集合から独立に列挙した自明セクターと比較する | PASS | 格子サイズ3件 |
| `check_inverse_roundtrip_source.sage` | $B=\delta_L^{-1}(\delta_L(B))$ | PASS | 265集合 |
| `check_inverse_substitution.sage` | 双対像が等しい二集合に逆写像を施す | PASS | 全65,601組のうち等しい双対像を持つ265組 |
| `check_inverse_roundtrip_other.sage` | $\delta_L^{-1}(\delta_L(B'))=B'$ | PASS | 265組 |
| `check_cardinality_definition.sage` | $\lvert\Delta_L(B)\rvert=\lvert\delta_L(B)\rvert$ | PASS | 265集合 |
| `check_cardinality_preservation.sage` | $\lvert\delta_L(B)\rvert=\lvert B\rvert$ | PASS | 265集合 |
| `check_partition_low_temperature.sage` | $Z_L=2D_L$ | PASS | 格子サイズ3件 |
| `check_low_temperature_sum.sage` | $D_L$ の定義を有限和で開く | PASS | 格子サイズ3件 |
| `check_weight_cardinality_substitution.sage` | 指数の元数を双対像の元数へ置換する | PASS | 格子サイズ3件 |
| `check_reindex_sum.sage` | 全単射によって有限和の添字を取り替える | PASS | 格子サイズ3件 |
| `check_sector_polynomial_definition.sage` | 自明セクターの有限和を $G_L^{0,0}$ へ戻す | PASS | 格子サイズ3件 |

行別ファイルは `check.sage` が作る同じ厳密データを受け取り、本文の各等号を一つずつ検査する。
自明セクターは全辺部分集合から、実現できる破れ集合は全530配位から独立に列挙する。
各格子サイズの実現できる破れ集合は1・8・256個である。浮動小数点は使わない。

## 実行方法

```sh
sage sagemath/check/sector-generating-polynomial/check.sage
```

**2026-08-13 実行: すべて通過。**

2026-10-04: 行別12本と既存の多項式恒等式が全て通過した。
この VM ではプロジェクト直下で
`micromamba run -p /home/masaori/.local/share/math-mamba/envs/sage sage -c "__file__ = 'sagemath/check/sector-generating-polynomial/check.sage'; load(__file__)"`
を実行した。

同日の最初の実行は、検算内の既存の局所変数が追加した双対像関数と同名だったため
`TypeError: 'frozenset' object is not callable` で停止した。局所変数名を修正して再実行した結果が上表であり、数学的な検証条件は変えていない。
