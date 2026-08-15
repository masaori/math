# 有限双曲曲面上の Ising 模型のタスク依存関係

## ゴール

有限群・剰余類データから得た閉双曲曲面の有限セル分割について、Ising 分配多項式、
高温展開のホモロジー類別、主格子・双対格子間の有限 Fourier 変換を構成し、
係数・素因数付値・Fisher 零点・商の塔への依存を追跡できる状態にする。

## 依存関係

```text
有限セル分割の入力と検査
├── 有限群と剰余類からの格子生成
│   └── 商の塔と被覆写像
├── Ising 分配多項式
│   ├── 係数と素因数付値
│   └── Fisher 零点
└── F_2 セル鎖複体
    └── 高温展開のホモロジー類別
        └── 有限 Fourier 双対
            └── 主格子・双対格子の変換

商の塔と被覆写像
├── 係数列・付値列の比較
└── Fisher 零点列の比較
```

## 実行可能な最初の作業

- [有限セル分割の入力と検査](definitions/finite-cellulation.md)
- [Ising 分配多項式](partition-polynomial/ising-partition-polynomial.md)

この二つは有限グラフの共通語彙を共有する。自動 tick は同じ tick で両方を進めず、
既に書かれた定義と衝突しないかをレビューしてから一方だけを進める。

## 後続の作業

- [有限群と剰余類からの格子生成](quotient-lattice/finite-group-cosets.md)
- [`F_2` セル鎖複体とホモロジー類別](homology/high-temperature-sectors.md)
- [有限 Fourier 双対](duality/finite-fourier-duality.md)
- [係数・素因数付値・Fisher 零点](arithmetic/coefficients-valuations-fisher-zeros.md)
- [商の塔への依存](quotient-tower/tower-dependence.md)

