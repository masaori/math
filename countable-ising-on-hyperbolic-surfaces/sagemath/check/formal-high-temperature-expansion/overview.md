# 形式的高温展開の検算

**対象ラベル**: `theorem_formal_high_temperature_expansion`

## 検算内容

有限グラフを全列挙し、`ZZ[u,v]` 上で次の二つを独立に構成して等号を検査する。

- 全スピン配位にわたる形式的辺重み積の和
- 偶辺部分集合にわたる生成多項式の `2^{|V|}` 倍

浮動小数点、実数、近似は使わない。

## 実行状態

- 状態: PASS
- 実行日: 2026-08-15
- 結果: 四つの有限グラフについて `ZZ[u,v]` 上の両辺が一致した。
- 実行コマンド: `sage sagemath/check/formal-high-temperature-expansion/check.sage`
