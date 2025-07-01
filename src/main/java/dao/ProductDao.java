/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this
 * license Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Product;

import static dao.DBHelper.getConnection;

/**
 *
 * @author Nguyen_Hoang_Ngoc_Chau
 */
public class ProductDao {
    private static final String INSERT_PRODUCT_SQL = "INSERT INTO dbo.products (product_image, product_name, description, unit_price, quantity_in_stock) VALUES (?, ?, ?, ?, ?)";
    private static final String UPDATE_PRODUCT_SQL = "UPDATE dbo.products SET product_image = ?, product_name = ?, description = ?, unit_price = ?, quantity_in_stock = ? WHERE product_id = ?";
    private static final String DELETE_PRODUCT_SQL = "DELETE FROM dbo.products WHERE product_id = ?";
    private static final String SELECT_PRODUCT_BY_ID = "SELECT * FROM dbo.products WHERE product_id = ?";
    private static final String SELECT_ALL_PRODUCTS = "SELECT * FROM dbo.products";

    public void insertProduct(Product product) {
        try (Connection connection = getConnection();
                java.sql.PreparedStatement preparedStatement = connection.prepareStatement(INSERT_PRODUCT_SQL)) {
            preparedStatement.setString(1, product.getProductImage());
            preparedStatement.setString(2, product.getProductName());
            preparedStatement.setString(3, product.getDescription());
            preparedStatement.setDouble(4, product.getUnitPrice());
            preparedStatement.setInt(5, product.getQuantityInStock());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateProduct(Product product) {
        try (Connection connection = getConnection();
                java.sql.PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_PRODUCT_SQL)) {
            preparedStatement.setString(1, product.getProductImage());
            preparedStatement.setString(2, product.getProductName());
            preparedStatement.setString(3, product.getDescription());
            preparedStatement.setDouble(4, product.getUnitPrice());
            preparedStatement.setInt(5, product.getQuantityInStock());
            preparedStatement.setString(6, product.getProductId());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteProduct(String productId) {
        try (Connection connection = getConnection();
                java.sql.PreparedStatement preparedStatement = connection.prepareStatement(DELETE_PRODUCT_SQL)) {
            preparedStatement.setString(1, productId);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Product selectProduct(String productId) {
        Product product = null;
        try (Connection connection = getConnection();
                java.sql.PreparedStatement preparedStatement = connection.prepareStatement(SELECT_PRODUCT_BY_ID)) {
            preparedStatement.setString(1, productId);
            java.sql.ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                product = new Product();
                product.setProductId(resultSet.getString("product_id"));
                product.setProductImage(resultSet.getString("product_image"));
                product.setProductName(resultSet.getString("product_name"));
                product.setDescription(resultSet.getString("description"));
                product.setUnitPrice(resultSet.getDouble("unit_price"));
                product.setQuantityInStock(resultSet.getInt("quantity_in_stock"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return product;
    }

    public List<Product> selectAllProducts(int limit) {
        List<Product> products = new ArrayList<>();
        String query;
        if (limit == -1) {
            query = SELECT_ALL_PRODUCTS;
        } else {
            query = SELECT_ALL_PRODUCTS + " ORDER BY product_id DESC OFFSET 0 ROWS FETCH NEXT " + limit + " ROWS ONLY";
        }
        try (Connection connection = getConnection();
                java.sql.PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            java.sql.ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                // Kiểm tra số lượng sản phẩm trong kho
                if (resultSet.getInt("quantity_in_stock") <= 0) {
                    continue; //
                }
                Product product = new Product();
                product.setProductId(resultSet.getString("product_id"));
                product.setProductImage(resultSet.getString("product_image"));
                product.setProductName(resultSet.getString("product_name"));
                product.setDescription(resultSet.getString("description"));
                product.setUnitPrice(resultSet.getDouble("unit_price"));
                product.setQuantityInStock(resultSet.getInt("quantity_in_stock"));
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    public List<Product> searchProducts(String keyword) {
        if (keyword == null || keyword.isEmpty()) {
            return selectAllProducts(-1);
        }
        List<Product> products = new ArrayList<>();
        for (Product p : selectAllProducts(-1)) {
            if (p.getProductName().toLowerCase().contains(keyword.toLowerCase())) {
                products.add(p);
            }
        }
        return products;
    }
}
