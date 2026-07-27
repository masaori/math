# 章 011 `trace_power_sandwich` Step 2: モーメント対数凸性の添字指定が誤り

- 対象: `structured-latex/content/011_max_eigenvalue.ts`
  / `maxeig_008_claim_trace_power_sandwich`（ラベル `trace_power_sandwich`）の Step 2
- 発見経緯: Lean 形式化（`lean/Ising2D/Abstract/RayleighMoments.lean` の
  `Ising2D.Abstract.IsPsdPair.moment_log_convex`）
- 結論そのもの（`m_k² ≤ m_{k-1} m_{k+1}`）は**正しい**。誤っているのは
  「どの `(a, b)` に対して 2 本の Cauchy–Schwarz を適用するか」の指定だけである。

## 原文の記述

Step 2 は次の 2 本を用意している（いずれも正しい）。

- `P = W` 版: `(m_{a+b+1})² ≤ m_{2a+1} · m_{2b+1}`
- `P = I` 版: `(m_{a+b})² ≤ m_{2a} · m_{2b}`

そのうえで本文はこう書いている。

> これらをまとめると、任意の `k ∈ ℤ_{≥1}` について `a = k-1`、`b = k+1` の場合
> （および `a+b` が偶数の場合）を合わせて
> `m_k² ≤ m_{k-1} m_{k+1}`
> が成り立つ（`2k = (k-1)+(k+1)` なので、上の 2 式のうち偶奇の合う方を
> `a = ⌊(k-1)/2⌋` 等に対して適用する）。

## 何が誤りか

`a = k-1`, `b = k+1` を `P = W` 版へ代入すると

```
(m_{(k-1)+(k+1)+1})² = (m_{2k+1})² ≤ m_{2k-1} · m_{2k+3}
```

となり、示したい `m_k² ≤ m_{k-1} m_{k+1}` とは別の不等式になる。
`P = I` 版へ代入しても `(m_{2k})² ≤ m_{2k-2} m_{2k+2}` で、やはり別物である。
括弧内の `a = ⌊(k-1)/2⌋ 等` は正しい向きだが、`b` の指定も偶奇の割り当ても書かれていない。

## 正しい添字（Lean で確認した形）

`m_{k+1}² ≤ m_k · m_{k+2}` の形で書くと次のとおり（`k ≥ 0`）。

| `k` の偶奇 | 使う不等式 | `(a, b)` | 代入結果 |
| --- | --- | --- | --- |
| `k = 2p`（`k+1` は奇数） | `P = I` 版 | `(p, p+1)` | `(m_{2p+1})² ≤ m_{2p} · m_{2p+2}` |
| `k = 2p+1`（`k+1` は偶数） | `P = W` 版 | `(p, p+1)` | `(m_{2p+2})² ≤ m_{2p+1} · m_{2p+3}` |

すなわち **`k+1` が奇数のときに `P = I` 版、`k+1` が偶数のときに `P = W` 版**を使う。
原文の `m_k² ≤ m_{k-1} m_{k+1}`（`k ≥ 1`）の記法へ直すと、
`k` が奇数なら `P = I` 版で `(a,b) = ((k-1)/2, (k+1)/2)`、
`k` が偶数なら `P = W` 版で `(a,b) = (k/2-1, k/2)` である。

## 一次情報

`lean/Ising2D/Abstract/RayleighMoments.lean`:

```lean
theorem moment_log_convex (h : IsPsdPair ip W) (x : V) (k : ℕ) :
    (ip x ((W ^ (k + 1)) x)) ^ 2
      ≤ (ip x ((W ^ k) x)) * (ip x ((W ^ (k + 2)) x)) := by
  rcases Nat.even_or_odd k with ⟨p, hp⟩ | ⟨p, hp⟩
  · -- k = p + p（偶数）⇒ P = I 版、(a, b) = (p, p+1)
    ...
    have hcs := h.cs_ip ((W ^ p) x) ((W ^ (p + 1)) x)
    ...
  · -- k = 2p+1（奇数）⇒ P = W 版、(a, b) = (p, p+1)
    ...
    have hcs := h.cs_W ((W ^ p) x) ((W ^ (p + 1)) x)
    ...
```

`lake build` と `./scripts/check-no-sorry.sh` はいずれも成功している（`sorry` ゼロ）。

## 提案する修正（本文の修正は別セッション担当）

Step 2 の最後の段落を、上の表のとおり「`k+1` の偶奇でどちらの不等式を使うか」と
`(a, b) = (⌊k/2⌋, ⌊k/2⌋+1)` を明示する形へ書き換える。
定理の主張と結論は変更不要。
