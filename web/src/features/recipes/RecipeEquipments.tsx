import { gql } from '@apollo/client';
import React from 'react';
import { Link } from 'react-router-dom';
import { RecipeEquipmentsFragment } from '../../graphql/types';

export const RECIPE_EQUIPMENTS_FRAGMENT = gql`
  fragment RecipeEquipments on Recipe {
    equipments {
      id
      name
      quantity
    }
  }
`;

export const RecipeEquipments: React.FC<RecipeEquipmentsFragment> = ({ equipments }) => {
  return (
    <>
      <h2>Equipment</h2>
      <ul>
        {equipments.map((equipment) =>
          <li key={equipment.id}>
            <Link to={`/equipment/${equipment.id}`}>
              {equipment.name}
            </Link>
            {equipment.quantity &&
              <span> - &times;{equipment.quantity}</span>
            }
          </li>
        )}
      </ul>
    </>
  )
};
