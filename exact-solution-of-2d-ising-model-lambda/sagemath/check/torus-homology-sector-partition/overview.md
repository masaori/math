# SageMath Check: 周期トーラスの四つの辺セクター

## 対象

**対象ラベル**: `claim_torus_homology_sector_partition`

- 併せて検証: `def_torus_winding_parities`, `def_torus_homology_sector`
- 範囲: 二つの周期境界を横切る辺の個数の偶奇と、偶部分グラフの四セクターへの一意な分割

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
|---|---|---|---|
| `check.sage` | $L=1,2,3$ の全辺部分集合から偶部分グラフを取り、二つの偶奇で四セクターへ一意に分かれることを検査する | PASS | 偶部分グラフは各セクターにただ一度だけ属し、四セクターはいずれも空でない |
| `check_winding_values.sage` | 構成した組 $(a,b)$ が $\{0,1\}\times\{0,1\}$ に属する | PASS | 全1,060偶部分グラフ |
| `check_witness_membership.sage` | 構成した組について $A\in\mathcal E_L^{a,b}$ | PASS | 全1,060偶部分グラフ |
| `check_other_horizontal.sage` | 別の所属候補について $a'=\varepsilon_{L,\mathrm h}(A)$ | PASS | 全1,060偶部分グラフの四候補を独立判定 |
| `check_witness_horizontal.sage` | $\varepsilon_{L,\mathrm h}(A)=a$ | PASS | 全1,060偶部分グラフ |
| `check_other_vertical.sage` | 別の所属候補について $b'=\varepsilon_{L,\mathrm v}(A)$ | PASS | 全1,060偶部分グラフの四候補を独立判定 |
| `check_witness_vertical.sage` | $\varepsilon_{L,\mathrm v}(A)=b$ | PASS | 全1,060偶部分グラフ |
| `check_pair_unique.sage` | $(a',b')=(a,b)$ と所属候補の一意性 | PASS | 全1,060偶部分グラフの四候補を独立判定 |

## 備考

辺は番号つきで扱うため、$L=1$ の二つの自己ループも別々に数える。すべて有限集合と整数の剰余の厳密計算であり、浮動小数点と $\mathbb{R}/\mathbb{C}$ は使わない。

行別検算では全辺部分集合の頂点次数の偶奇から偶部分グラフを列挙し、構成する組は切断辺集合との共通部分の元数から計算する。所属候補は四組すべてを境界辺の指示関数の和で独立に判定する。構成した組をキーにして振り分けた結果だけを、一意性の根拠にはしない。

## 実行方法

プロジェクト直下で実行する。`check.sage` は既存の全列挙の後で行別7本を実行する。行別ファイルも同じディレクトリから単独実行できる。

```sh
sage sagemath/check/torus-homology-sector-partition/check.sage
```

**2026-08-12 実行: すべて通過。**

2026-10-04 再実行: 一辺一・二・三の偶部分グラフ4・32・1,024個で通過。一意性の式変形を一行ずつ分けた本文と照合した。

2026-10-04 行別検算: 行別7本を各1,060個で実行して通過した。最初の実行では SageMath 10.9 のファイル実行時に `sys.argv[1]` が無く、読込先の取得が `IndexError` で停止した。プロジェクト直下からの相対パスへ直し、同じ検査条件で再実行した。
