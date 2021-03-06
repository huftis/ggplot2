context("scale_discrete")

# Ranges ------------------------------------------------------------------

test_that("discrete ranges also encompas continuous values", {
  df <- data.frame(x1 = c("a", "b", "c"), x2 = c(0, 2, 4), y = 1:3)

  base <- ggplot(df, aes(y = y)) + scale_x_discrete()

  x_range <- function(x) {
    layer_scales(x)$x$dimension()
  }

  expect_equal(x_range(base + geom_point(aes(x1))), c(1, 3))
  expect_equal(x_range(base + geom_point(aes(x2))), c(0, 4))
  expect_equal(x_range(base + geom_point(aes(x1)) + geom_point(aes(x2))), c(0, 4))
})

test_that("discrete scale shrinks to range when setting limits", {
  df <- data.frame(x = letters[1:10], y = 1:10)
  p <- ggplot(df, aes(x, y)) + geom_point() +
    scale_x_discrete(limits = c("a", "b"))

  expect_equal(layer_scales(p)$x$dimension(c(0, 1)), c(0, 3))
})
