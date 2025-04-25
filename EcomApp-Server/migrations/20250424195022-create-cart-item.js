'use strict';
/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.createTable('CartItems', {
      id: {
        allowNull: false,
        autoIncrement: true,
        primaryKey: true,
        type: Sequelize.INTEGER
      },
      cart_id: {
        type: Sequelize.INTEGER,
        allowNull: false, // Ensure it is not nullable
        references: {
          model: 'Carts', // The name of the Cart table
          key: 'id' // The column in Cart table to reference
        },
        onDelete: 'CASCADE', // Delete CartItems when the referenced Cart is deleted
        onUpdate: 'CASCADE', // Update CartItems when the referenced Cart is updated
      },
      product_id: {
        type: Sequelize.INTEGER,
        allowNull: false, // Ensure it is not nullable
        references: {
          model: 'Products', // The name of the Product table
          key: 'id' // The column in Product table to reference
        },
        onDelete: 'CASCADE', // Delete CartItems when the referenced Product is deleted
        onUpdate: 'CASCADE', // Update CartItems when the referenced Product is updated
      },
      quantity: {
        type: Sequelize.INTEGER,
        allowNull: false, // Ensure it is not nullable
      },
      createdAt: {
        allowNull: false,
        type: Sequelize.DATE,
        defaultValue: Sequelize.NOW // Default value as the current timestamp
      },
      updatedAt: {
        allowNull: false,
        type: Sequelize.DATE,
        defaultValue: Sequelize.NOW // Default value as the current timestamp
      }
    });
  },
  async down(queryInterface, Sequelize) {
    await queryInterface.dropTable('CartItems');
  }
};
