# Λ-statement プログラム（共通土台 seed）

このファイルは3トラック（`docs/themes.md`: 1 Reframe / 2 Solve / 3 Pure）**共通の土台**＝決定可能性の梯子・四軸・帰属台帳・選別基準を定める。トラックに依らず statement は **「Λ/ℚ̄ で決定可能・ℝ脱出隔離・形式検証可能」** を満たす。

（旧: 文献の「厳密可解」分類から本基準へ再定義した経緯。）
土台は `docs/discussion/対数順序群上の統計力学/`（README, 00 記号と定義, 07 帰属と可解性は別, 09 2DIsing 可算的導出）と `docs/discussion/可算性の効用/`。本 seed はその要約と、収集の選別基準・探索方向。

## 決定可能性の梯子（収集の座標系）

$$\underbrace{\mathbb{N}\subset\mathbb{Q}\subset\Lambda\subset\overline{\mathbb{Q}}}_{\text{無条件・厳密に決定可能}}\ \subset\ \underbrace{\overline{\mathbb{Q}}(\ell_p)\ \text{の非線形部}}_{\text{Schanuel 条件付き・回避}}\ \subset\ \underbrace{\mathbb{R}/\mathbb{C}}_{\text{決定不能}}$$

- $\Lambda=\bigoplus_{p}\mathbb{Z}\ell_p$（対数順序群）: 等号＝素因数分解一致、順序＝整数比較。無条件決定可能。
- $\overline{\mathbb{Q}}$（代数的数, Fisher/Lee–Yang 零点, 臨界点）: 等号・順序＝根分離。無条件（SageMath `QQbar`）。
- exp/log の体（$\ell_p\ell_q$ の積）: Schanuel 条件付き → **進まない**。
- $\mathbb{R}/\mathbb{C}$: 決定不能。脱出は (a) β定数化・指数丸め、(b) 示量極限 $N\to\infty$、(c) 量子なしの方向微分 の三箇所のみ。

## 量の帰属台帳（09 由来。収集する statement が指す対象の住処）

| 量 | 帰属 |
|---|---|
| 多重度 $\Omega_N(m)$ | $\mathbb{N}$ |
| 分配多項式 $Z_N(x)=\sum_m\Omega_N(m)x^m$ | $\mathbb{Z}[x]$ |
| Massieu 自由エントロピー $\Phi_N=\log Z_N(q),\ q\in\mathbb{Q}_{>0}$ | $\Lambda$ |
| 転送行列 $T(x)$ | $M_{d}(\mathbb{Z}[x])$ |
| 固有値・分散関係 | $\overline{\mathbb{Q}(x)}$（円分体つき） |
| Fisher/Lee–Yang 零点 | $\overline{\mathbb{Q}}$（$\mathbb{Z}[x]$ の根） |
| 臨界点 $x_c$（例 2DIsing $\sqrt2-1$） | $\overline{\mathbb{Q}}$ |
| 自由エネルギー閉形式・非解析性 | 前因子は $\Lambda_\mathbb{Q}$＋ $\mathbb{R}$ は連続極限の積分だけ |

## 四軸（07 由来。statement を分類・選別する軸）

1. **帰属/存在**: 有限・離散なら $\Omega\in\mathbb{N},S\in\Lambda,Z\in\mathbb{Z}[x],$ 零点 $\in\overline{\mathbb{Q}}$。連続スピン/無限サイズだと最初から $\mathbb{R}$ で**不可**。
2. **計算可能性**: 有限・離散なら常に○（数え上げで終わる）。模型を区別しない自明軸。
3. **複雑性**: 有限 $N$ で多項式（平面 Ising=Pfaffian）か #P 困難（3D, スピングラス）か。**有限側の本体軸**。
4. **可解性**: 極限に閉形式があるか（Onsager 在／3D 無）。**極限側の軸**。3 とは独立。可解性は別構造（双対・Yang–Baxter・自由フェルミオン）から来る。

$\Lambda$ は 1 を（有限・離散のとき）保証するだけ。2・3・4 は保証しない。

## 良い Λ-statement の選別基準（候補が満たすべき条件）

- **(i) 帰属が無条件**: 対象量が $\Lambda$ または $\overline{\mathbb{Q}}$ に住み、等号・順序が決定可能（素因数分解／根分離）。Schanuel 層・$\mathbb{R}$ を本体に含まない。
- **(ii) ℝ脱出が隔離**: $\mathbb{R}$ が要るのが一点（連続極限など）に限定でき、その一点を明示できる。または $\mathbb{R}$ を一切使わない（有限 $N$ 命題）。
- **(iii) 形式検証可能**: SageMath `ZZ/QQ/QQbar`・素因数分解で厳密計算でき、原理的に Lean/Coq の `decide`／reflection・witness 提示に乗る。
- **(iv) 単一の説明可能なずれ**: 既知アンカーから 1 つの軸（境界・rank・模型・複雑性・可解性）だけ動かした形。

## 探索方向（A〜F。**この周は絞らず全部を広く**浅く回す）

- **A. 分配関数零点 ∈ ℚ̄**: 各模型・境界の Fisher/Lee–Yang 零点の厳密シンボリック軌跡・代数性。06 が「可算再定式化が未踏＝差分」と明記。`QQbar` で実演可能。
- **B. 臨界点の代数性・双対固定**: $x_c\in\overline{\mathbb{Q}}$ がいつ・どの双対（KW / star-triangle 自己双対）で代数的に決まるか。08 と直結。
- **C. ℝ脱出隔離 / 自由フェルミオン構造**: どの模型・境界で「$T(x)\in M(\mathbb{Z}[x])$ を保ち、対角化が円分体つき $\overline{\mathbb{Q}(x)}$ で閉じ、$\mathbb{R}$ が連続極限の一点に隔離されるか」。09 Step1–3 の構造保存性。可解性軸（07-4）の中身。
- **D. Massieu $\Phi_N\in\Lambda$ の有限サイズ恒等式**: 自由エントロピーを素因数分解ベクトルとして表す有限 $N$ 恒等式・漸化式。
- **E. 複雑性×可解性の分類**: 各模型・境界を 07 のテーブル（多項式/#P × 閉形式有/無）に配置する分類命題そのもの。
- **F. 形式検証可能性**: どの厳密結果が $\Lambda$/$\overline{\mathbb{Q}}$ 上で `decide` 可能な形に落ちるか（第〇法則 $\beta_A=\beta_B$ の整数比較化など）。

## 模型の基質

`models.md`（six-vertex, RSOS, loop/TL, dimer, Potts ...）を Λ レンズを当てる対象集合として使う。模型自体は文献由来でよい（基質）。文献に引きずられてはいけないのは**整理軸・選別軸**（梯子・四軸）であって模型リストではない。

## 旧アプローチとの差（なぜ作り直したか）

cycle 0（削除済み, 復元点 918af09）は statement を「determinant か character か・境界が何か」という文献分類で集めた。これは梯子・四軸を使っておらず、可解性（文献の exact）と帰属（Λ）を混同していた。本 seed は整理軸を梯子＋四軸に、選別軸を (i)–(iv) に張り替える。
