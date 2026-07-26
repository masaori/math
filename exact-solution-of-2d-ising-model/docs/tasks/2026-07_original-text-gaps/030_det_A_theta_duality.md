# det A(θ\_μ) = 1 には双対関係 c₂s₂\* = c₂\* が要る件

**現況: 一部未解消。** 必要な等式そのものは本文に入っており、証明の連鎖もつながっているが、
`det_A_theta` の proof が参照している先が実質的に空証明であり、
「どの前提から det A = 1 が出るのか」が本文から追えない。**本文の修正が必要。**

## 対象

- ブロック `id`: `TV1_hatZ_hatY_035_claim_det_A_theta`
- `labels`: `det_A_theta`
- ファイル: `structured-latex/content/008_TV1_hatZ_hatY_part2.mjs`

関係するブロック:

| `id` | `labels` | 役割 |
| --- | --- | --- |
| `TV1_hatZ_hatY_016a_claim_duality_c2_star` | `duality_c2_star_eq_s2_star_c2` | `s₂* = 1/s₂`, `c₂* = c₂/s₂`, ゆえに `c₂* = s₂*c₂`（証明済み） |
| `TV1_hatZ_hatY_018_claim_T_V_action` | `T_V_hatZ_hatY` | proof の Step 2〜6 で `B₁(θ)B₂B₁(θ) = A(θ)` を 4 成分すべて計算（双対関係を使用） |
| `TV1_hatZ_hatY_037_claim_factorization_A_theta` | `factorization_of_A_theta` | 同じ行列等式を主張するが、proof は「作用行列が B₁B₂B₁ であり def\_A\_theta より A(θ)」の 1 段落のみ |
| `TV1_hatZ_hatY_035_claim_det_A_theta` | `det_A_theta` | `factorization_of_A_theta` を参照して det を計算 |

## (1) どの条件が抜けているか

`det A(θ) = 1` は **`def_A_theta` の A(θ) の定義だけからは出ない。**
A(θ) を γ₁, γ₂ で書くと

```
A(θ) = ( γ₁(θ)      γ₂(θ)  )
       ( −γ₂(−θ)    γ₁(θ)  )
det A(θ) = γ₁(θ)² + γ₂(θ)γ₂(−θ)
```

であり、これが 1 になるには c₁, s₁, c₂, c₂\*, s₂\* の間の関係が要る。実際に必要十分なだけの関係は

```
c₁² − s₁² = 1,    (c₂*)² − (s₂*)² = 1,    c₂ s₂* = c₂*
```

の 3 本である。前 2 本は cosh/sinh の恒等式だが、**3 本目 `c₂s₂* = c₂*` は K₂ と K₂\* の
双対関係（`sinh 2K₂ · sinh 2K₂* = 1`）の帰結であり、cosh/sinh の恒等式からは出ない。**

現在の `det_A_theta` の proof は

> `factorization_of_A_theta` より A(θ\_μ) = B₁(θ\_μ)·B₂·B₁(θ\_μ) であり、
> det B₁ = cosh²K₁ − sinh²K₁ = 1、det B₂ = cosh²(2K₂\*) − sinh²(2K₂\*) = 1、
> よって det A = (det B₁)²·det B₂ = 1

となっている。この計算自体は正しい（det B₁ の計算では非対角成分の積
`(−i e^{iθ}sinh K₁)(i e^{−iθ}sinh K₁) = sinh²K₁` を使う）。問題は参照先である。

`factorization_of_A_theta` の proof は

> `calc_of_TxT_hatZxhatY` より T\_{(V₁)^{1/2}} は (Ẑ, Ŷ) に右から B₁ を掛け、T\_{(V₂)} は
> 右から B₂ を掛ける。T\_{(V)} = … と `def_A_theta` の定義から A(θ\_μ) = B₁B₂B₁。

の 1 段落だけで、**行列等式の実証を含んでいない。** 2 つの問題がある。

1. **双対関係がどこにも現れない。** そのため「det A = 1 は c₂s₂\* = c₂\* に依存する」ことが
   本文の証明の連鎖から読み取れない。
2. **作用素の等式から行列の等式を導く段が飛んでいる。**
   `(T(Ẑ), T(Ŷ)) = (Ẑ, Ŷ)P` と `(T(Ẑ), T(Ŷ)) = (Ẑ, Ŷ)A` から `P = A` を結論するには
   Ẑ\_μ^{(−)}, Ŷ\_μ の線型独立性が要る。

実際の行列計算は `T_V_hatZ_hatY`（`TV1_hatZ_hatY_018_claim_T_V_action`）の proof の
Step 2〜6 に 4 成分すべて書かれており、その Step 4 で

```
P₁₂ = i e^{iθ}[ s₂*(c₁cos θ − i sin θ) − c₂* s₁ ]
    = i e^{iθ}[ s₂*(c₁cos θ − i sin θ) − s₂* c₂ s₁ ]   (∵ c₂* = s₂* c₂)
    = i e^{iθ} s₂*(c₁cos θ − i sin θ − s₁c₂) = γ₂(θ)
```

と、`duality_c2_star_eq_s2_star_c2` を明示的に参照して使っている。**つまり必要な情報は
本文に揃っているが、`det_A_theta` からそこへ辿れない。**

## (2) 正しくはどうあるべきか（修正後のステートメント案）

### 案 A（最小の修正・推奨）

`det_A_theta` の statement に前提を明記し、proof の参照先を実証のあるブロックへ張り替える。

> **statement 案**
>
> `def_transfer_matrix_symbols` の記号のもと K₁, K₂ ∈ ℝ\_{>0} とする。μ ∈ ℳ について、
>
> ```
> det A(θ_μ) = 1,   γ₁(θ_μ)² + γ₂(θ_μ)γ₂(−θ_μ) = 1,   λ_{+,μ}·λ_{−,μ} = 1
> ```
>
> ここで第 1 式は A(θ) の定義（`def_A_theta`）だけからは従わず、
> cosh/sinh の恒等式 c₁² − s₁² = 1、(c₂\*)² − (s₂\*)² = 1 に加えて
> 双対関係の帰結 c₂s₂\* = c₂\*（`duality_c2_star_eq_s2_star_c2`）を用いる。

> **proof 案**
>
> `T_V_hatZ_hatY` の proof の Step 2〜6 で B₁(θ\_μ)B₂B₁(θ\_μ) = A(θ\_μ) が
> 4 成分すべて確認されている（その Step 4・Step 5 で `duality_c2_star_eq_s2_star_c2` を使う）。
> 以下は現行どおり det B₁ = 1、det B₂ = 1 から det A = 1。

### 案 B（`factorization_of_A_theta` を直す）

`factorization_of_A_theta` の proof を、`T_V_hatZ_hatY` の Step 2〜6 の行列計算を参照する
形に書き換える（作用素の等式を経由しない）。そのうえで `det_A_theta` は現行のまま
`factorization_of_A_theta` を参照してよい。**上記 2. の飛躍も同時に消えるので、
本文全体としてはこちらのほうが望ましい。**

いずれの案でも、`det_A_theta` の statement に「K₁, K₂ ∈ ℝ\_{>0}」（双対関係が
定義される前提）が要る点は共通である。

## (3) 反例と検算の根拠

### 数値による反例（双対関係を壊すと det A ≠ 1 になる）

K₁ = 0.4, K₂ = 0.7、K₂\* = −(1/2)log(tanh K₂) とし、θ = 2π/5 で計算する。

| c₂ の値 | det A(θ) |
| --- | --- |
| `c₂ = cosh 2K₂`（双対関係が成立: `c₂* − s₂*c₂ = 0.0`） | `1.0000000000000004` |
| `c₂ = cosh 2K₂ + 0.3`（双対関係を破る） | `0.7604629971731727` |
| `c₂ = 1.0`（双対関係を破る） | `1.555753967051494` |

A(θ) の他の成分（c₁, s₁, c₂\*, s₂\*）は cosh/sinh の恒等式を満たしたままなので、
**この 3 行は「cosh/sinh の恒等式だけでは det A = 1 が出ない」ことの直接の反例**である。
再現コード（Python 3、標準ライブラリのみ）:

```python
import cmath, math
K1, K2 = 0.4, 0.7
c1, s1 = math.cosh(2*K1), math.sinh(2*K1)
c2 = math.cosh(2*K2)
K2s = -0.5*math.log(math.tanh(K2))
c2s, s2s = math.cosh(2*K2s), math.sinh(2*K2s)
def A(th, c2v):
    g1  = c1*c2s - s1*s2s*math.cos(th)
    g2  = 1j*cmath.exp( 1j*th)*s2s*(c1*math.cos(th) - 1j*math.sin(th) - s1*c2v)
    g2m = 1j*cmath.exp(-1j*th)*s2s*(c1*math.cos(th) + 1j*math.sin(th) - s1*c2v)
    return g1*g1 - g2*(-g2m)          # det
th = 2*math.pi/5
print(A(th, c2), A(th, c2+0.3), A(th, 1.0))
```

### Lean の裏づけ

`lean/Ising2D/Part008/Claim027_EigenATheta.lean`:

- `Ising2D.det_AMat` — **無条件**に成り立つ形
  `det A(θ) = γ₁(θ)² + γ₂(θ)γ₂(−θ)`
- `Ising2D.det_AMat_eq_one` — 上が `1` になるための仮定を明示した形。仮定は
  `c₁² − s₁² = 1`、`(c₂*)² − (s₂*)² = 1`、`c₂ s₂* = c₂*` の 3 本

この 2 つが別々の定理になっていること自体が、「無条件で言えるのはどこまでか」と
「1 になるのに何が要るか」を分離した機械的裏づけである。

双対関係そのものの Lean 側の対応は、`lean/Ising2D/Part008/Definition016_TV.lean` の
`Ising2D.B1_mul_B2_mul_B1_eq_explicit` / `Ising2D.B1_mul_B2_mul_B1_eq_AMat` の仮定
`hdual : s₂* c₂ = c₂*` である（この仮定を落とすと `B₁B₂B₁ = A(θ)` が証明できない）。
