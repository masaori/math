# 検算: Clifford 代数の塔が行列環の塔であること

**対象ラベル**: 未昇格（構造化記述の命題ではなく、探索文書「有限代数系から無限代数系が現れる機構」の具体例）
→ [`../../../docs/有限代数系から無限代数系が現れる機構.md`](../../../docs/有限代数系から無限代数系が現れる機構.md)
の「具体例」節。

## 確認する主張

$$
\mathrm{Cl}_{2n}(\mathbb{C})\ \cong\ M_{2^n}(\mathbb{C}),\qquad
\mathrm{Cl}_{2n}\subset\mathrm{Cl}_{2n+2}\ \text{は}\ M_{2^n}\hookrightarrow M_{2^{n+1}},\ a\mapsto a\otimes 1 .
$$

Jordan–Wigner の明示的な生成元

$$
e_{2k-1}=\sigma_z^{\otimes(k-1)}\otimes\sigma_x\otimes 1^{\otimes(n-k)},\qquad
e_{2k}=\sigma_z^{\otimes(k-1)}\otimes\sigma_y\otimes 1^{\otimes(n-k)}
$$

について、次の二つを有限計算で確かめる。

1. **Clifford 関係式** $e_ie_j+e_je_i=2\delta_{ij}$ が $2n$ 個すべての組で成り立つ。
2. **全射性** — 生成元の部分集合の積 $e_S=\prod_{i\in S}e_i$（$2^{2n}$ 個）が
   $M_{2^n}(\mathbb{C})$ の**基底**になる。すなわち一次独立な本数が $4^n=\dim M_{2^n}$ に等しい。

$(2)$ が成り立てば $\mathrm{Cl}_{2n}\to M_{2^n}$ は全射であり、次元が両辺 $4^n$ で等しいので同型。

## 実行

```sh
python3 clifford_is_matrix_algebra.py
```

SageMath を要さない（純 Python、係数は Gauss 整数 $\mathbb{Z}[i]$ の範囲に収まる）。
一次独立性の判定にのみ複素数の除算を使うが、現れる値は $\{0,\pm1,\pm i\}$ である。

## 結果

| $n$ | 主張 | Clifford 関係式 | 積の個数 | 一次独立な本数 | $\dim M_{2^n}$ | 判定 |
|---|---|---|---|---|---|---|
| 1 | $\mathrm{Cl}_2\cong M_2$ | 成立 | 4 | 4 | 4 | **合致** |
| 2 | $\mathrm{Cl}_4\cong M_4$ | 成立 | 16 | 16 | 16 | **合致** |
| 3 | $\mathrm{Cl}_6\cong M_8$ | 成立 | 64 | 64 | 64 | **合致** |

$n=1,2,3$ で確認した。$n$ 一般の証明ではない（帰納法の骨子は上記文書に記す）。

## $\mathbb{R}$ 脱出

**なし。** 係数は $\mathbb{Z}[i]\subset\overline{\mathbb{Q}}$ に収まり、
判定はすべて有限次元の一次独立性（有限個の等号）である。
