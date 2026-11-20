# SageMath Check: 根の番号の対の個数

## 対象

**対象ラベル**: `claim_root_index_pair_count`

- 実行日: 2026-11-20
- 結果: 全検査通過（PASS 683）
- 帰属: すべて自然数（Sage の `ZZ` の非負の元）と有限集合。浮動小数点は使わない。
- 標本: 帰納法の一歩は $0\le e<40$、結論の式鎖は $1\le d\le40$（$\nu$ は $\mathrm{Pr}_d$ の元を辞書式に並べた全単射）。

## 何を確かめるか

- 準備: $C_{e+1}\subset\mathrm{Pr}_{e+2}$、$\mathrm{Pr}_{e+1}\cap C_{e+1}=\emptyset$、$\mathrm{Pr}_{e+1}\cup C_{e+1}=\mathrm{Pr}_{e+2}$、$i\mapsto(i,e+1)$ が $\mathbb{N}_{<e+1}\to C_{e+1}$ の全単射であること。
- 個数の式鎖の二つの等号（$|\mathrm{Pr}_{e+2}|=|\mathrm{Pr}_{e+1}|+|C_{e+1}|=|\mathrm{Pr}_{e+1}|+(e+1)$）。
- 基底: $\mathrm{Pr}_1=\emptyset$ と式鎖の二つの等号。
- 帰納法の一歩の式鎖の四つの等号と、各 $e$ での帰納法の仮定そのもの。
- 結論の式鎖の五つの等号（$N+N=\dots=d\cdot(d-1)$）。

有限個の標本の検算であり、普遍量化された主張の証明ではない。

## 実行方法

```sh
sage check.sage
```
